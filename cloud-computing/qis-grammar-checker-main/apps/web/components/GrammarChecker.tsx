"use client";

import React, { useState, useRef } from 'react';
import {
    Search,
    CheckCircle2,
    AlertCircle,
    ArrowRight,
    Copy,
    RotateCcw,
    Sparkles,
    Type as TypeIcon,
    MessageSquare,
    FileText,
    ChevronDown,
    ChevronUp,
    Loader2,
    Check
} from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import Markdown from 'react-markdown';
import { cn } from "@/lib/utils";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import {
    Accordion,
    AccordionContent,
    AccordionItem,
    AccordionTrigger,
} from "@/components/ui/accordion";
import { checkGrammarAction } from "@/app/actions";
import type { GrammarCheckResult, GrammarCorrection } from "@/lib/gemini";

export default function GrammarChecker() {
    const [inputText, setInputText] = useState('');
    const [isAnalyzing, setIsAnalyzing] = useState(false);
    const [result, setResult] = useState<GrammarCheckResult | null>(null);
    const [error, setError] = useState<string | null>(null);
    const [copied, setCopied] = useState(false);
    const resultRef = useRef<HTMLDivElement>(null);

    const handleCheck = async () => {
        if (!inputText.trim()) return;

        setIsAnalyzing(true);
        setError(null);
        // We keep the previous result while analyzing for a smoother transition if desired, 
        // but here we clear it to show the loading state clearly in the split view.
        setResult(null);

        try {
            const response = await checkGrammarAction(inputText);
            if (response.error) {
                throw new Error(response.error);
            }
            if (response.data) {
                setResult(response.data);
            }
        } catch (err) {
            setError(err instanceof Error ? err.message : 'An unexpected error occurred');
        } finally {
            setIsAnalyzing(false);
        }
    };

    const handleCopy = (text: string) => {
        navigator.clipboard.writeText(text);
        setCopied(true);
        setTimeout(() => setCopied(false), 2000);
    };

    const handleApplyAll = () => {
        if (result?.improvedVersion) {
            setInputText(result.improvedVersion);
            // Optional: clear result after apply or keep it? 
            // Usually keeping it is fine so they can see the score of what they just applied.
        }
    };

    const handleReset = () => {
        setInputText('');
        setResult(null);
        setError(null);
    };

    const getScoreColor = (score: number) => {
        if (score >= 90) return 'text-emerald-600';
        if (score >= 70) return 'text-blue-600';
        if (score >= 50) return 'text-amber-600';
        return 'text-rose-600';
    };

    const getTypeIcon = (type: GrammarCorrection['type']) => {
        switch (type) {
            case 'grammar': return <TypeIcon className="w-4 h-4 text-blue-500" />;
            case 'phrasing': return <MessageSquare className="w-4 h-4 text-purple-500" />;
            case 'punctuation': return <AlertCircle className="w-4 h-4 text-amber-500" />;
            case 'spelling': return <Search className="w-4 h-4 text-rose-500" />;
        }
    };

    // A simple component to render text with highlights for corrections
    const DiffText = ({ text, corrections }: { text: string, corrections: GrammarCorrection[] }) => {
        if (!corrections.length) return <Markdown>{text}</Markdown>;

        // Sort corrections by length (descending) to avoid partial matches if possible, 
        // though Gemini usually gives unique enough snippets.
        const sortedCorrections = [...corrections].sort((a, b) => b.correction.length - a.correction.length);

        // This is a naive implementation: it wraps corrections in a span.
        // For a true diff, a library would be better, but this matches Gemini's output.
        let highlighted = text;
        sortedCorrections.forEach((c) => {
            // We escape special characters for regex
            const escaped = c.correction.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
            const regex = new RegExp(`(${escaped})`, 'g');
            // We use a temporary placeholder to avoid double-processing
            highlighted = highlighted.replace(regex, `<mark class="bg-emerald-500/10 text-emerald-700 px-1 rounded transition-colors" title="${c.explanation}">$1</mark>`);
        });

        return (
            <div
                className="prose prose-slate max-w-none break-words whitespace-pre-wrap overflow-hidden"
                dangerouslySetInnerHTML={{ __html: highlighted }}
            />
        );
    };

    return (
        <div className="max-w-[1400px] mx-auto px-4 py-8">
            <div className={cn(
                "grid gap-8 transition-all duration-500 ease-in-out",
                result ? "grid-cols-1 lg:grid-cols-2" : "grid-cols-1"
            )}>
                {/* Input Column */}
                <motion.section
                    layout
                    className="space-y-4"
                >
                    <div className="flex items-center justify-between mb-2">
                        <h2 className="text-xl font-bold text-foreground flex items-center gap-2">
                            <FileText className="w-5 h-5 text-primary" />
                            Input Text
                        </h2>
                        {result && (
                            <Button variant="outline" size="sm" onClick={handleReset} className="h-8 text-xs font-bold uppercase tracking-wider text-muted-foreground">
                                <RotateCcw className="w-3 h-3 mr-1" /> New Text
                            </Button>
                        )}
                    </div>

                    <Card className="overflow-hidden border shadow-sm transition-all focus-within:ring-2 focus-within:ring-ring/20 bg-card min-h-[400px] flex flex-col">
                        <Textarea
                            value={inputText}
                            onChange={(e) => setInputText(e.target.value)}
                            placeholder="Type or paste your text here..."
                            className="flex-grow p-6 resize-none border-none focus-visible:ring-0 text-lg leading-relaxed text-foreground placeholder:text-muted-foreground min-h-[300px]"
                        />
                        <div className="px-6 py-4 bg-muted/30 border-t flex items-center justify-between">
                            <div className="flex flex-col">
                                <span className="text-[10px] font-bold text-muted-foreground uppercase tracking-widest">
                                    {inputText.length} chars
                                </span>
                                <span className="text-[10px] font-bold text-muted-foreground uppercase tracking-widest">
                                    {inputText.split(/\s+/).filter(Boolean).length} words
                                </span>
                            </div>
                            <Button
                                onClick={handleCheck}
                                disabled={isAnalyzing || !inputText.trim()}
                                className="rounded-xl font-bold shadow-sm px-8 h-12 active:scale-95 transition-all text-base"
                            >
                                {isAnalyzing ? (
                                    <>
                                        <Loader2 className="w-5 h-5 mr-3 animate-spin" />
                                        Analyzing...
                                    </>
                                ) : (
                                    <>
                                        Analyze Text
                                        <ArrowRight className="w-5 h-5 ml-3" />
                                    </>
                                )}
                            </Button>
                        </div>
                    </Card>

                    {error && (
                        <motion.div
                            initial={{ opacity: 0, y: 10 }}
                            animate={{ opacity: 1, y: 0 }}
                            className="p-4 bg-destructive/10 border border-destructive/20 rounded-xl flex items-center gap-3 text-destructive text-sm font-medium"
                        >
                            <AlertCircle className="w-5 h-5 flex-shrink-0" />
                            {error}
                        </motion.div>
                    )}

                    {!result && !isAnalyzing && (
                        <motion.div
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            className="pt-12 text-center"
                        >
                            <div className="w-16 h-16 bg-primary/5 rounded-2xl flex items-center justify-center mx-auto mb-6">
                                <Sparkles className="w-8 h-8 text-primary/40" />
                            </div>
                            <h3 className="text-2xl font-black text-foreground mb-2">Write better, faster</h3>
                            <p className="text-muted-foreground max-w-sm mx-auto mb-8 font-medium">
                                Paste your draft and let AI polish your grammar, tone, and clarity instantly.
                            </p>
                            <div className="flex justify-center gap-3">
                                {['Grammar', 'Style', 'Spelling'].map(tag => (
                                    <Badge key={tag} variant="secondary" className="px-3 py-1 bg-card border text-[10px] font-bold text-muted-foreground uppercase tracking-widest">
                                        {tag}
                                    </Badge>
                                ))}
                            </div>
                        </motion.div>
                    )}
                </motion.section>

                {/* Results Column */}
                <AnimatePresence>
                    {result && (
                        <motion.section
                            initial={{ opacity: 0, x: 20 }}
                            animate={{ opacity: 1, x: 0 }}
                            exit={{ opacity: 0, x: 20 }}
                            className="space-y-6"
                        >
                            <div className="flex items-center justify-between mb-2">
                                <h2 className="text-xl font-bold text-foreground flex items-center gap-2">
                                    <CheckCircle2 className="w-5 h-5 text-emerald-600" />
                                    Analysis Results
                                </h2>
                                <div className="flex items-center gap-3">
                                    <div className={cn("text-2xl font-black px-3 py-1 rounded-lg bg-card border shadow-sm", getScoreColor(result.score))}>
                                        {result.score}
                                    </div>
                                    <span className="text-[10px] font-bold text-muted-foreground uppercase tracking-widest">Score</span>
                                </div>
                            </div>

                            <Card className="bg-card border shadow-sm overflow-hidden">
                                <CardHeader className="bg-muted/30 border-b py-3">
                                    <CardTitle className="text-xs font-bold uppercase tracking-widest text-muted-foreground">Expert Summary</CardTitle>
                                </CardHeader>
                                <CardContent className="pt-4">
                                    <p className="text-foreground leading-relaxed font-medium">
                                        {result.summary}
                                    </p>
                                </CardContent>
                            </Card>

                            <div className="space-y-3">
                                <div className="flex items-center justify-between">
                                    <h3 className="text-sm font-bold text-muted-foreground uppercase tracking-widest flex items-center gap-2">
                                        Improvements Made
                                        <Badge variant="secondary" className="rounded-full h-5 min-w-5 flex items-center justify-center border-none">
                                            {result.corrections.length}
                                        </Badge>
                                    </h3>
                                    <div className="flex gap-2">
                                        <Button
                                            variant="ghost"
                                            size="sm"
                                            onClick={() => handleCopy(result.improvedVersion)}
                                            className="h-8 text-[10px] font-bold uppercase tracking-widest text-muted-foreground"
                                        >
                                            {copied ? <Check className="w-3 h-3 mr-1" /> : <Copy className="w-3 h-3 mr-1" />}
                                            {copied ? 'Copied' : 'Copy'}
                                        </Button>
                                        <Button
                                            variant="secondary"
                                            size="sm"
                                            onClick={handleApplyAll}
                                            className="h-8 bg-secondary text-secondary-foreground hover:bg-secondary/80 text-[10px] font-bold uppercase tracking-widest border"
                                        >
                                            <Sparkles className="w-3 h-3 mr-1" />
                                            Apply All
                                        </Button>
                                    </div>
                                </div>

                                <Card className="bg-muted/10 border shadow-sm min-h-[250px] flex flex-col">
                                    <div className="p-6 flex-grow leading-relaxed text-lg text-foreground">
                                        <DiffText text={result.improvedVersion} corrections={result.corrections} />
                                    </div>
                                </Card>
                            </div>

                            {result.corrections.length > 0 && (
                                <div className="space-y-3">
                                    <h3 className="text-xs font-bold text-muted-foreground uppercase tracking-widest">Context & Explanations</h3>
                                    <Accordion type="single" collapsible className="space-y-2">
                                        {result.corrections.map((correction, idx) => (
                                            <AccordionItem
                                                key={idx}
                                                value={`item-${idx}`}
                                                className="bg-card border rounded-xl px-4 transition-all hover:bg-muted/20"
                                            >
                                                <AccordionTrigger className="hover:no-underline py-3 px-1 sm:px-4 min-w-0">
                                                    <div className="flex items-center gap-3 text-left w-full min-w-0 overflow-hidden">
                                                        <div className="shrink-0 p-1.5 bg-card border rounded-md shadow-sm">
                                                            {getTypeIcon(correction.type)}
                                                        </div>
                                                        <div className="flex-grow min-w-0 overflow-hidden">
                                                            <div className="flex items-center gap-2 min-w-0">
                                                                <span className="line-through text-muted-foreground text-[10px] sm:text-xs truncate max-w-[40%] shrink-0">{correction.original}</span>
                                                                <ArrowRight className="w-3 h-3 text-muted-foreground/30 shrink-0" />
                                                                <span className="font-bold text-foreground text-xs sm:text-sm truncate flex-grow min-w-0">{correction.correction}</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </AccordionTrigger>
                                                <AccordionContent className="pb-4">
                                                    <div className="text-xs text-muted-foreground leading-relaxed pl-1 sm:pl-10 pr-2 break-words overflow-hidden">
                                                        <div className="flex flex-wrap gap-x-1">
                                                            <strong className="text-foreground uppercase tracking-tighter shrink-0 font-black">{correction.type}:</strong>
                                                            <span>{correction.explanation}</span>
                                                        </div>
                                                    </div>
                                                </AccordionContent>
                                            </AccordionItem>
                                        ))}
                                    </Accordion>
                                </div>
                            )}
                        </motion.section>
                    )}
                </AnimatePresence>
            </div>
        </div>
    );
}
