"use server";

import { checkGrammar, type GrammarCheckResult } from "@/lib/gemini";

export async function checkGrammarAction(text: string): Promise<{ data?: GrammarCheckResult; error?: string }> {
    if (!text.trim()) {
        return { error: "Text is required" };
    }

    try {
        const result = await checkGrammar(text);
        return { data: result };
    } catch (error) {
        return { error: error instanceof Error ? error.message : "An unexpected error occurred" };
    }
}
