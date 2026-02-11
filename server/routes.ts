import type { Express } from "express";
import { type Server } from "http";
import { setupAuth, registerAuthRoutes } from "./replit_integrations/auth";
import { storage } from "./storage";
import { api } from "@shared/routes";
import { z } from "zod";
import { openai } from "./replit_integrations/image/client";
import { WebSocketServer, WebSocket } from "ws";

export async function registerRoutes(httpServer: Server, app: Express): Promise<Server> {
  // Setup Replit Auth
  await setupAuth(app);
  registerAuthRoutes(app);

  // Setup WebSocket
  const wss = new WebSocketServer({ server: httpServer, path: '/ws' });

  wss.on('connection', (ws) => {
    ws.on('message', (message) => {
      // Handle incoming messages if needed
    });
  });

  const broadcast = (data: any) => {
    wss.clients.forEach((client) => {
      if (client.readyState === WebSocket.OPEN) {
        client.send(JSON.stringify(data));
      }
    });
  };

  // Middleware to ensure auth
  const requireAuth = (req: any, res: any, next: any) => {
    if (req.isAuthenticated()) return next();
    res.status(401).json({ message: "Unauthorized" });
  };

  app.get(api.memos.list.path, requireAuth, async (req, res) => {
     const userId = (req.user as any).claims.sub;
     const memos = await storage.getMemos(userId);
     res.json(memos);
  });

  app.post(api.memos.create.path, requireAuth, async (req, res) => {
    try {
        const userId = (req.user as any).claims.sub;
        const input = api.memos.create.input.parse(req.body);

        // Get pet settings
        let settings = await storage.getUserSettings(userId);
        if (!settings) {
            settings = await storage.updateUserSettings(userId, { petName: "Buddy", petType: "dog" });
        }

        // Generate AI response
        const prompt = `You are a ${settings.petType} named ${settings.petName}. 
        The user wrote a memo: "${input.content}".
        Respond to this memo in a cute, supportive way, as if you are the pet. 
        Keep it short (1-2 sentences). 
        Include some animal sounds appropriate for a ${settings.petType} (e.g. "Woof!", "Meow!").`;

        const response = await openai.chat.completions.create({
            model: "gpt-5.1",
            messages: [{ role: "system", content: prompt }],
            max_completion_tokens: 100,
        });

        const petResponse = response.choices[0].message.content || "...";

        const memo = await storage.createMemo(userId, input, petResponse);
        broadcast({ type: 'MEMO_CREATED', payload: memo });
        res.status(201).json(memo);
    } catch (e) {
        console.error(e);
        if (e instanceof z.ZodError) {
          res.status(400).json({ message: e.errors[0].message });
        } else {
          res.status(500).json({ message: "Failed to create memo" });
        }
    }
  });

  app.delete(api.memos.delete.path, requireAuth, async (req, res) => {
      const userId = (req.user as any).claims.sub;
      const id = Number(req.params.id);
      await storage.deleteMemo(id, userId);
      broadcast({ type: 'MEMO_DELETED', payload: { id } });
      res.status(204).send();
  });

  app.get(api.settings.get.path, requireAuth, async (req, res) => {
      const userId = (req.user as any).claims.sub;
      let settings = await storage.getUserSettings(userId);
      if (!settings) {
          settings = { userId, petName: "Buddy", petType: "dog", theme: "light" };
      }
      res.json(settings);
  });

  app.put(api.settings.update.path, requireAuth, async (req, res) => {
      const userId = (req.user as any).claims.sub;
      const input = api.settings.update.input.parse(req.body);
      const settings = await storage.updateUserSettings(userId, input);
      res.json(settings);
  });

  return httpServer;
}
