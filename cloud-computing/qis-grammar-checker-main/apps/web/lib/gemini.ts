import { GoogleGenAI, Type } from "@google/genai";

let aiInstance: GoogleGenAI | null = null;

function getAI() {
    const apiKey = process.env.GEMINI_API_KEY || "";
    if (!apiKey) {
        throw new Error("GEMINI_API_KEY is not set. Please add it to your .env file.");
    }
    if (!aiInstance) {
        aiInstance = new GoogleGenAI({ apiKey });
    }
    return aiInstance;
}

export interface GrammarCorrection {
    original: string;
    correction: string;
    explanation: string;
    type: "grammar" | "phrasing" | "punctuation" | "spelling";
}

export interface GrammarCheckResult {
    score: number;
    summary: string;
    corrections: GrammarCorrection[];
    improvedVersion: string;
}

export async function checkGrammar(text: string): Promise<GrammarCheckResult> {
    const ai = getAI();
    const response = await ai.models.generateContent({
        model: "gemini-3-flash-preview",
        contents: [
            {
                role: "user",
                parts: [
                    {
                        text: `Check the following text for grammar, punctuation, and style: "${text}"`
                    }
                ]
            }
        ],
        config: {
            responseMimeType: "application/json",
            responseSchema: {
                type: Type.OBJECT,
                properties: {
                    score: {
                        type: Type.NUMBER,
                        description: "A score from 0 to 100 based on grammar and clarity.",
                    },
                    summary: {
                        type: Type.STRING,
                        description: "A brief summary of the writing quality.",
                    },
                    corrections: {
                        type: Type.ARRAY,
                        items: {
                            type: Type.OBJECT,
                            properties: {
                                original: { type: Type.STRING, description: "The original incorrect snippet." },
                                correction: { type: Type.STRING, description: "The suggested correction." },
                                explanation: { type: Type.STRING, description: "Why this change is suggested." },
                                type: {
                                    type: Type.STRING,
                                    enum: ["grammar", "phrasing", "punctuation", "spelling"],
                                    description: "The category of the error."
                                },
                            },
                            required: ["original", "correction", "explanation", "type"],
                        },
                    },
                    improvedVersion: {
                        type: Type.STRING,
                        description: "The complete text with all improvements applied.",
                    },
                },
                required: ["score", "summary", "corrections", "improvedVersion"],
            },
        },
    });

    const candidate = response.candidates?.[0];
    const resultText = candidate?.content?.parts?.[0]?.text;

    if (!resultText) {
        throw new Error("Failed to get response from Gemini AI");
    }

    try {
        return JSON.parse(resultText) as GrammarCheckResult;
    } catch (error) {
        console.error("Failed to parse Gemini AI response:", resultText);
        throw new Error("Failed to parse the grammar check result.");
    }
}
