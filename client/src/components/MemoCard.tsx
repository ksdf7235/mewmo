import { motion } from "framer-motion";
import { formatDistanceToNow } from "date-fns";
import { Trash2 } from "lucide-react";
import { PetAvatar } from "./PetAvatar";
import { useDeleteMemo } from "@/hooks/use-memos";
import { Button } from "@/components/ui/button";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
  AlertDialogTrigger,
} from "@/components/ui/alert-dialog";

interface MemoCardProps {
  id: number;
  content: string;
  petResponse?: string | null;
  createdAt: string | Date;
  petType: string;
  petName: string;
}

export function MemoCard({ id, content, petResponse, createdAt, petType, petName }: MemoCardProps) {
  const deleteMemo = useDeleteMemo();

  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      className="group relative bg-white rounded-3xl p-6 shadow-sm border border-border/50 hover:shadow-md transition-all duration-300 overflow-hidden"
    >
      {/* Decorative top bar */}
      <div className="absolute top-0 left-0 right-0 h-2 bg-gradient-to-r from-primary/30 to-accent/30" />

      {/* Header */}
      <div className="flex justify-between items-start mb-4 mt-2">
        <span className="text-xs font-semibold text-muted-foreground bg-stone-100 px-3 py-1 rounded-full">
          {formatDistanceToNow(new Date(createdAt), { addSuffix: true })}
        </span>
        
        <AlertDialog>
          <AlertDialogTrigger asChild>
            <Button 
              variant="ghost" 
              size="icon" 
              className="h-8 w-8 text-muted-foreground/50 hover:text-destructive hover:bg-destructive/10 rounded-full opacity-0 group-hover:opacity-100 transition-opacity"
            >
              <Trash2 className="w-4 h-4" />
            </Button>
          </AlertDialogTrigger>
          <AlertDialogContent className="rounded-2xl">
            <AlertDialogHeader>
              <AlertDialogTitle className="font-display text-xl">Delete this memory?</AlertDialogTitle>
              <AlertDialogDescription>
                This action cannot be undone. This will permanently delete your memo.
              </AlertDialogDescription>
            </AlertDialogHeader>
            <AlertDialogFooter>
              <AlertDialogCancel className="rounded-xl">Cancel</AlertDialogCancel>
              <AlertDialogAction 
                onClick={() => deleteMemo.mutate(id)}
                className="bg-destructive hover:bg-destructive/90 text-destructive-foreground rounded-xl"
              >
                Delete
              </AlertDialogAction>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialog>
      </div>

      {/* User Content */}
      <div className="mb-8">
        <p className="text-lg text-foreground leading-relaxed font-body">
          {content}
        </p>
      </div>

      {/* Pet Response - Chat Bubble Style */}
      {petResponse ? (
        <div className="flex gap-4 items-end mt-4">
          <PetAvatar type={petType} size="sm" className="shrink-0 mb-1" />
          <div className="bg-secondary/30 rounded-2xl rounded-bl-none p-4 text-secondary-foreground text-sm leading-relaxed relative flex-1">
             <span className="font-bold text-xs block text-secondary-foreground/70 mb-1">{petName} says:</span>
             {petResponse}
          </div>
        </div>
      ) : (
        <div className="flex gap-3 items-center mt-4 text-muted-foreground text-sm italic bg-stone-50 p-3 rounded-xl border border-stone-100">
          <PetAvatar type={petType} size="sm" mood="thinking" className="opacity-70 scale-75" />
          {petName} is reading...
        </div>
      )}
    </motion.div>
  );
}
