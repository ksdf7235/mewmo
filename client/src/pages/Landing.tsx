import { Button } from "@/components/ui/button";
import { PetAvatar } from "@/components/PetAvatar";
import { Sparkles, ArrowRight } from "lucide-react";
import { motion } from "framer-motion";

export default function Landing() {
  const handleLogin = () => {
    window.location.href = "/api/login";
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-orange-50 via-white to-purple-50 relative overflow-hidden">
      
      {/* Background Blobs */}
      <div className="absolute top-[-20%] right-[-10%] w-[500px] h-[500px] bg-primary/10 rounded-full blur-3xl" />
      <div className="absolute bottom-[-20%] left-[-10%] w-[600px] h-[600px] bg-secondary/20 rounded-full blur-3xl" />

      {/* Nav */}
      <nav className="relative z-10 flex justify-between items-center p-6 md:px-12">
        <div className="flex items-center gap-2">
          <PetAvatar type="dog" size="sm" className="bg-white shadow-sm" />
          <span className="font-display font-bold text-xl text-foreground">PetMemo</span>
        </div>
        <Button onClick={handleLogin} variant="outline" className="rounded-full border-primary/20 text-primary hover:bg-primary/5">
          Login
        </Button>
      </nav>

      {/* Hero */}
      <main className="relative z-10 container mx-auto px-4 py-12 md:py-24 flex flex-col items-center text-center">
        
        <motion.div
          initial={{ scale: 0.8, opacity: 0 }}
          animate={{ scale: 1, opacity: 1 }}
          transition={{ duration: 0.5 }}
          className="inline-flex items-center gap-2 bg-white/60 backdrop-blur-sm border border-white/50 px-4 py-2 rounded-full mb-8 shadow-sm"
        >
          <Sparkles className="w-4 h-4 text-accent-foreground" />
          <span className="text-sm font-medium text-muted-foreground">Your AI Companion Journal</span>
        </motion.div>

        <motion.h1 
          initial={{ y: 20, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          transition={{ delay: 0.1, duration: 0.6 }}
          className="text-5xl md:text-7xl font-display font-bold text-foreground mb-6 leading-tight tracking-tight"
        >
          Share your thoughts with <br className="hidden md:block" />
          <span className="text-transparent bg-clip-text bg-gradient-to-r from-primary to-blue-400">
            someone who cares
          </span>
        </motion.h1>

        <motion.p 
          initial={{ y: 20, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          transition={{ delay: 0.2, duration: 0.6 }}
          className="text-lg md:text-xl text-muted-foreground max-w-2xl mb-10 leading-relaxed"
        >
          PetMemo gives you a safe space to vent, celebrate, or reflect. 
          Your virtual pet listens and responds with kindness, every time.
        </motion.p>

        <motion.div
          initial={{ y: 20, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          transition={{ delay: 0.3, duration: 0.6 }}
        >
          <Button 
            onClick={handleLogin}
            size="lg" 
            className="h-16 px-10 rounded-full text-xl font-display bg-foreground text-background hover:bg-foreground/90 shadow-xl bounce-hover gap-3"
          >
            Get Started
            <ArrowRight className="w-5 h-5" />
          </Button>
        </motion.div>

        {/* Floating Avatars Decoration */}
        <div className="mt-20 flex gap-8 md:gap-16 justify-center flex-wrap opacity-80">
          <motion.div animate={{ y: [0, -10, 0] }} transition={{ repeat: Infinity, duration: 4, ease: "easeInOut" }}>
             <PetAvatar type="dog" size="lg" mood="happy" className="bg-white shadow-lg rotate-[-6deg]" />
          </motion.div>
          <motion.div animate={{ y: [0, -15, 0] }} transition={{ repeat: Infinity, duration: 5, ease: "easeInOut", delay: 1 }}>
             <PetAvatar type="cat" size="lg" mood="thinking" className="bg-white shadow-lg rotate-[3deg]" />
          </motion.div>
          <motion.div animate={{ y: [0, -8, 0] }} transition={{ repeat: Infinity, duration: 3.5, ease: "easeInOut", delay: 0.5 }}>
             <PetAvatar type="rabbit" size="lg" mood="sleeping" className="bg-white shadow-lg rotate-[-3deg]" />
          </motion.div>
        </div>

      </main>
    </div>
  );
}
