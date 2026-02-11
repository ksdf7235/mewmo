import { users, memos, userSettings, type Memo, type InsertMemo, type UserSettings, type InsertSettings } from "@shared/schema";
import { db } from "./db";
import { eq, desc } from "drizzle-orm";

export interface IStorage {
  getMemos(userId: string): Promise<Memo[]>;
  createMemo(userId: string, memo: InsertMemo, response: string): Promise<Memo>;
  deleteMemo(id: number, userId: string): Promise<void>;
  getUserSettings(userId: string): Promise<UserSettings | undefined>;
  updateUserSettings(userId: string, settings: InsertSettings): Promise<UserSettings>;
}

export class DatabaseStorage implements IStorage {
  async getMemos(userId: string): Promise<Memo[]> {
    return await db.select().from(memos).where(eq(memos.userId, userId)).orderBy(desc(memos.createdAt));
  }

  async createMemo(userId: string, memo: InsertMemo, response: string): Promise<Memo> {
    const [newMemo] = await db.insert(memos).values({
      userId,
      content: memo.content,
      imageUrl: memo.imageUrl,
      petResponse: response,
    }).returning();
    return newMemo;
  }

  async deleteMemo(id: number, userId: string): Promise<void> {
    await db.delete(memos).where(eq(memos.id, id));
  }

  async getUserSettings(userId: string): Promise<UserSettings | undefined> {
    const [settings] = await db.select().from(userSettings).where(eq(userSettings.userId, userId));
    return settings;
  }

  async updateUserSettings(userId: string, settings: InsertSettings): Promise<UserSettings> {
     const [updated] = await db.insert(userSettings)
        .values({ userId, ...settings })
        .onConflictDoUpdate({
            target: userSettings.userId,
            set: settings
        })
        .returning();
     return updated;
  }
}

export const storage = new DatabaseStorage();
