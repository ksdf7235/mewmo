import { Dog, Cat, Rabbit, Rat } from "lucide-react";
import { motion } from "framer-motion";

interface PetAvatarProps {
  type: string; // 'dog' | 'cat' | 'rabbit' | 'hamster'
  size?: "sm" | "md" | "lg" | "xl";
  className?: string;
  mood?: "happy" | "thinking" | "sleeping";
}

export function PetAvatar({ type, size = "md", className = "", mood = "happy" }: PetAvatarProps) {
  const sizeClasses = {
    sm: "w-8 h-8 p-1.5",
    md: "w-12 h-12 p-2.5",
    lg: "w-20 h-20 p-4",
    xl: "w-32 h-32 p-6",
  };

  const getIcon = () => {
    switch (type.toLowerCase()) {
      case "cat": return <Cat className="w-full h-full text-orange-500" />;
      case "rabbit": return <Rabbit className="w-full h-full text-pink-500" />;
      case "hamster": return <Rat className="w-full h-full text-amber-500" />; // Rat looks close enough to hamster
      default: return <Dog className="w-full h-full text-amber-700" />;
    }
  };

  const getBgColor = () => {
    switch (type.toLowerCase()) {
      case "cat": return "bg-orange-100 border-orange-200";
      case "rabbit": return "bg-pink-100 border-pink-200";
      case "hamster": return "bg-amber-100 border-amber-200";
      default: return "bg-amber-100 border-amber-200";
    }
  };

  const animations = {
    happy: { y: [0, -5, 0], transition: { repeat: Infinity, duration: 2, repeatDelay: 1 } },
    thinking: { rotate: [0, 5, -5, 0], transition: { repeat: Infinity, duration: 3 } },
    sleeping: { scale: [1, 0.98, 1], opacity: 0.8, transition: { repeat: Infinity, duration: 2 } },
  };

  return (
    <motion.div
      animate={animations[mood]}
      className={`
        rounded-full border-2 flex items-center justify-center shadow-sm
        ${getBgColor()} ${sizeClasses[size]} ${className}
      `}
    >
      {getIcon()}
    </motion.div>
  );
}
