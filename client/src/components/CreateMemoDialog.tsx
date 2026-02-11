import { useState } from "react";
import { useCreateMemo } from "@/hooks/use-memos";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { Plus, Sparkles } from "lucide-react";
import { useToast } from "@/hooks/use-toast";

export function CreateMemoDialog() {
  const [open, setOpen] = useState(false);
  const [content, setContent] = useState("");
  const createMemo = useCreateMemo();
  const { toast } = useToast();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!content.trim()) return;

    createMemo.mutate(
      { content, imageUrl: null },
      {
        onSuccess: () => {
          setOpen(false);
          setContent("");
          toast({
            title: "Memo created!",
            description: "Your pet is thinking of a response...",
            className: "bg-primary text-primary-foreground",
          });
        },
        onError: () => {
          toast({
            title: "Error",
            description: "Failed to create memo. Please try again.",
            variant: "destructive",
          });
        },
      }
    );
  };

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        <Button 
          size="lg" 
          className="rounded-full shadow-lg shadow-primary/30 hover:shadow-primary/50 gap-2 h-14 px-8 text-lg font-display"
        >
          <Plus className="w-5 h-5" />
          Write Memo
        </Button>
      </DialogTrigger>
      <DialogContent className="sm:max-w-md bg-white/95 backdrop-blur-xl border-white/20 rounded-3xl">
        <DialogHeader>
          <DialogTitle className="text-2xl font-display text-primary flex items-center gap-2">
            <Sparkles className="w-5 h-5" />
            New Memory
          </DialogTitle>
        </DialogHeader>
        <form onSubmit={handleSubmit} className="space-y-6 mt-4">
          <div className="space-y-2">
            <Label htmlFor="content" className="text-muted-foreground font-medium pl-1">
              What's on your mind?
            </Label>
            <Textarea
              id="content"
              placeholder="Dear diary, today I..."
              className="min-h-[150px] resize-none border-2 border-primary/20 focus-visible:border-primary/50 focus-visible:ring-0 rounded-2xl bg-white/50 text-lg p-4 font-body"
              value={content}
              onChange={(e) => setContent(e.target.value)}
              disabled={createMemo.isPending}
            />
          </div>
          <DialogFooter>
            <Button 
              type="button" 
              variant="ghost" 
              onClick={() => setOpen(false)}
              className="rounded-xl text-muted-foreground hover:bg-stone-100"
            >
              Cancel
            </Button>
            <Button 
              type="submit" 
              disabled={createMemo.isPending}
              className="rounded-xl bg-primary hover:bg-primary/90 text-white shadow-lg shadow-primary/20"
            >
              {createMemo.isPending ? "Sharing..." : "Share with Pet"}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  );
}
