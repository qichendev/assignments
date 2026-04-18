import { GoogleGenAI } from "@google/genai";

async function listModels() {
    const apiKey = process.env.GEMINI_API_KEY;
    if (!apiKey) return;

    const ai = new GoogleGenAI({ apiKey });
    try {
        const pager = await ai.models.list();
        const models = pager.pageInternal || [];
        console.log("Found Flash models:");
        models.forEach(m => {
            if (m.name.toLowerCase().includes('flash')) {
                console.log(`- ${m.name}`);
            }
        });
    } catch (error) {
        console.error("Error:", error);
    }
}

listModels();
