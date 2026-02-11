import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { api, buildUrl } from "@shared/routes";
import { z } from "zod";

// Types inferred from schema via Zod
type Memo = z.infer<typeof api.memos.list.responses[200]>[number];
type CreateMemoInput = z.infer<typeof api.memos.create.input>;

export function useMemos() {
  return useQuery({
    queryKey: [api.memos.list.path],
    queryFn: async () => {
      const res = await fetch(api.memos.list.path, { credentials: "include" });
      if (!res.ok) throw new Error("Failed to fetch memos");
      return api.memos.list.responses[200].parse(await res.json());
    },
  });
}

export function useCreateMemo() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (data: CreateMemoInput) => {
      const validated = api.memos.create.input.parse(data);
      const res = await fetch(api.memos.create.path, {
        method: api.memos.create.method,
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(validated),
        credentials: "include",
      });

      if (!res.ok) {
        if (res.status === 400) {
          const error = api.memos.create.responses[400].parse(await res.json());
          throw new Error(error.message);
        }
        throw new Error("Failed to create memo");
      }
      return api.memos.create.responses[201].parse(await res.json());
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: [api.memos.list.path] });
    },
  });
}

export function useDeleteMemo() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (id: number) => {
      const url = buildUrl(api.memos.delete.path, { id });
      const res = await fetch(url, {
        method: api.memos.delete.method,
        credentials: "include",
      });

      if (!res.ok) {
        if (res.status === 404) throw new Error("Memo not found");
        throw new Error("Failed to delete memo");
      }
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: [api.memos.list.path] });
    },
  });
}
