import { useSettings, useUpdateSettings } from "@/hooks/use-settings";
import { useAuth } from "@/hooks/use-auth";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { PetAvatar } from "@/components/PetAvatar";
import { ArrowLeft, Loader2, LogOut } from "lucide-react";
import { Link, useLocation } from "wouter";
import { useEffect, useState } from "react";
import { useToast } from "@/hooks/use-toast";

const PET_TYPES = [
  { value: "dog", label: "Puppy" },
  { value: "cat", label: "Kitten" },
  { value: "rabbit", label: "Bunny" },
  { value: "hamster", label: "Hamster" },
];

export default function Settings() {
  const { data: settings, isLoading } = useSettings();
  const updateSettings = useUpdateSettings();
  const { logout, user } = useAuth();
  const [, setLocation] = useLocation();
  const { toast } = useToast();

  const [petName, setPetName] = useState("");
  const [petType, setPetType] = useState("dog");

  useEffect(() => {
    if (settings) {
      setPetName(settings.petName);
      setPetType(settings.petType);
    }
  }, [settings]);

  const handleSave = async (e: React.FormEvent) => {
    e.preventDefault();
    updateSettings.mutate(
      { petName, petType },
      {
        onSuccess: () => {
          toast({
            title: "Settings Saved",
            description: "Your pet has been updated!",
            className: "bg-primary text-primary-foreground",
          });
          setLocation("/");
        },
      }
    );
  };

  if (isLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <Loader2 className="w-8 h-8 animate-spin text-primary" />
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-stone-50">
      {/* Header */}
      <header className="bg-white border-b border-border sticky top-0 z-10">
        <div className="container max-w-2xl mx-auto px-4 h-16 flex items-center justify-between">
          <Link href="/">
            <Button variant="ghost" className="gap-2 -ml-2 text-muted-foreground hover:text-foreground">
              <ArrowLeft className="w-4 h-4" />
              Back
            </Button>
          </Link>
          <h1 className="font-display font-bold text-lg">Pet Settings</h1>
          <div className="w-16" /> {/* Spacer for centering */}
        </div>
      </header>

      <main className="container max-w-2xl mx-auto px-4 py-8 space-y-8">
        {/* Profile Card */}
        <div className="bg-white rounded-3xl p-8 shadow-sm border border-border">
          <div className="flex flex-col items-center mb-8">
            <div className="relative mb-4">
              <PetAvatar type={petType} size="xl" />
              <div className="absolute -bottom-2 -right-2 bg-primary text-white text-xs px-2 py-1 rounded-full font-bold shadow-sm">
                Lvl 1
              </div>
            </div>
            <h2 className="text-2xl font-display font-bold text-foreground">
              {petName || "Your Pet"}
            </h2>
            <p className="text-muted-foreground">Your companion</p>
          </div>

          <form onSubmit={handleSave} className="space-y-8">
            <div className="space-y-3">
              <Label htmlFor="petName" className="text-base font-semibold text-foreground">
                Pet Name
              </Label>
              <Input
                id="petName"
                value={petName}
                onChange={(e) => setPetName(e.target.value)}
                className="h-12 rounded-xl border-2 border-stone-100 bg-stone-50 px-4 text-lg focus-visible:ring-primary/20 focus-visible:border-primary"
                placeholder="Name your pet..."
              />
            </div>

            <div className="space-y-4">
              <Label className="text-base font-semibold text-foreground">Pet Type</Label>
              <RadioGroup
                value={petType}
                onValueChange={setPetType}
                className="grid grid-cols-2 sm:grid-cols-4 gap-4"
              >
                {PET_TYPES.map((type) => (
                  <div key={type.value}>
                    <RadioGroupItem
                      value={type.value}
                      id={type.value}
                      className="peer sr-only"
                    />
                    <Label
                      htmlFor={type.value}
                      className="flex flex-col items-center gap-3 p-4 rounded-2xl border-2 border-transparent bg-stone-50 cursor-pointer hover:bg-stone-100 peer-data-[state=checked]:border-primary peer-data-[state=checked]:bg-primary/5 transition-all"
                    >
                      <PetAvatar type={type.value} size="sm" className="bg-white" />
                      <span className="font-medium text-sm">{type.label}</span>
                    </Label>
                  </div>
                ))}
              </RadioGroup>
            </div>

            <Button 
              type="submit" 
              className="w-full h-12 rounded-xl bg-primary hover:bg-primary/90 text-white font-semibold text-lg shadow-lg shadow-primary/20 bounce-hover"
              disabled={updateSettings.isPending}
            >
              {updateSettings.isPending ? (
                <Loader2 className="w-5 h-5 animate-spin mr-2" />
              ) : null}
              Save Changes
            </Button>
          </form>
        </div>

        {/* Account Actions */}
        <div className="bg-white rounded-3xl p-6 shadow-sm border border-border">
          <h3 className="font-display font-bold text-lg mb-4">Account</h3>
          <div className="flex items-center justify-between p-4 bg-stone-50 rounded-2xl border border-stone-100">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-full bg-stone-200 overflow-hidden">
                {user?.profileImageUrl ? (
                  <img src={user.profileImageUrl} alt="Profile" className="w-full h-full object-cover" />
                ) : (
                  <div className="w-full h-full flex items-center justify-center text-muted-foreground font-bold">
                    {user?.firstName?.[0] || "U"}
                  </div>
                )}
              </div>
              <div>
                <p className="font-medium text-foreground">{user?.firstName} {user?.lastName}</p>
                <p className="text-sm text-muted-foreground">{user?.email}</p>
              </div>
            </div>
            <Button 
              variant="outline" 
              onClick={() => logout()}
              className="text-destructive hover:text-destructive hover:bg-destructive/5 border-destructive/20 rounded-xl gap-2"
            >
              <LogOut className="w-4 h-4" />
              Sign Out
            </Button>
          </div>
        </div>
      </main>
    </div>
  );
}
