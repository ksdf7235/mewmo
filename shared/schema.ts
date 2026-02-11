import { pgTable, text, serial, timestamp, varchar } from "drizzle-orm/pg-core";
import { createInsertSchema } from "drizzle-zod";
import { z } from "zod";
import { users } from "./models/auth";

export * from "./models/auth";

export const userSettings = pgTable("user_settings", {
  userId: varchar("user_id").primaryKey().references(() => users.id),
  petName: text("pet_name").notNull().default("Buddy"),
  petType: text("pet_type").notNull().default("dog"), // dog, cat, rabbit, hamster
});

export const memos = pgTable("memos", {
  id: serial("id").primaryKey(),
  userId: varchar("user_id").notNull().references(() => users.id),
  content: text("content").notNull(),
  petResponse: text("pet_response"), // The AI response
  imageUrl: text("image_url"), // Optional image attachment
  createdAt: timestamp("created_at").defaultNow(),
});

export const insertMemoSchema = createInsertSchema(memos).pick({
  content: true,
  imageUrl: true,
});

export const insertSettingsSchema = createInsertSchema(userSettings).omit({ userId: true });

export type Memo = typeof memos.$inferSelect;
export type UserSettings = typeof userSettings.$inferSelect;
