import { useMemos } from "@/hooks/use-memos";
import { useSettings } from "@/hooks/use-settings";
import { CreateMemoDialog } from "@/components/CreateMemoDialog";
import { MemoCard } from "@/components/MemoCard";
import { PetAvatar } from "@/components/PetAvatar";
import { useAuth } from "@/hooks/use-auth";
import { Loader2, Settings as SettingsIcon } from "lucide-react";
import { Link } from "wouter";
import { Button } from "@/components/ui/button";

export default function Dashboard() {
  const { data: memos, isLoading: loadingMemos } = useMemos();
  const { data: settings, isLoading: loadingSettings } = useSettings();
  const { user } = useAuth();

  if (loadingMemos || loadingSettings) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-background">
        <div className="text-center space-y-4">
          <PetAvatar type="dog" mood="thinking" size="lg" className="mx-auto" />
          <p className="text-muted-foreground font-display text-xl animate-pulse">
            Waking up your pet...
          </p>
        </div>
      </div>
    );
  }

  const petName = settings?.petName || "Buddy";
  const petType = settings?.petType || "dog";

  return (
    <div className="min-h-screen bg-background pb-20">
      {/* Header */}
      <header className="sticky top-0 z-10 bg-white/80 backdrop-blur-lg border-b border-border/50">
        <div className="container max-w-5xl mx-auto px-4 py-4 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <PetAvatar type={petType} size="md" />
            <div>
              <h1 className="text-xl font-display text-foreground leading-none">
                {petName}'s Corner
              </h1>
              <p className="text-sm text-muted-foreground mt-0.5">
                Welcome back, {user?.firstName || "Friend"}
              </p>
            </div>
          </div>
          
          <Link href="/settings">
            <Button variant="ghost" size="icon" className="rounded-full hover:bg-stone-100 text-muted-foreground">
              <SettingsIcon className="w-5 h-5" />
            </Button>
          </Link>
        </div>
      </header>

      {/* Main Content */}
      <main className="container max-w-3xl mx-auto px-4 py-8">
        
        {/* Empty State */}
        {memos?.length === 0 ? (
          <div className="flex flex-col items-center justify-center text-center py-20 bg-white rounded-[2.5rem] shadow-sm border border-dashed border-border mt-8">
            <PetAvatar type={petType} size="xl" mood="sleeping" className="mb-6 opacity-80" />
            <h2 className="text-2xl font-display text-foreground mb-2">No memories yet</h2>
            <p className="text-muted-foreground max-w-sm mb-8">
              {petName} is waiting to hear about your day. Write your first memo to get a response!
            </p>
            <CreateMemoDialog />
          </div>
        ) : (
          <div className="space-y-6">
            <div className="flex items-center justify-between mb-8">
              <h2 className="text-2xl font-display font-bold text-foreground">Recent Memories</h2>
              <CreateMemoDialog />
            </div>

            <div className="grid gap-6">
              {memos?.map((memo) => (
                <MemoCard
                  key={memo.id}
                  id={memo.id}
                  content={memo.content}
                  petResponse={memo.petResponse}
                  createdAt={memo.createdAt!}
                  petName={petName}
                  petType={petType}
                />
              ))}
            </div>
          </div>
        )}
      </main>
    </div>
  );
}
