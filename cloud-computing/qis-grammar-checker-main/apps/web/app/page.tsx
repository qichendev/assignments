import { Sparkles } from "lucide-react";
import GrammarChecker from "@/components/GrammarChecker";

export default function Home() {
  return (
    <div className="min-h-screen bg-slate-50/50">
      {/* Header */}
      <header className="bg-white/80 backdrop-blur-md border-b border-slate-200 sticky top-0 z-50">
        <div className="max-w-5xl mx-auto px-4 h-16 flex items-center justify-between">
          <div className="flex items-center gap-2">
            <div className="w-9 h-9 bg-primary rounded-xl flex items-center justify-center shadow-lg shadow-primary/20">
              <Sparkles className="w-5 h-5 text-white" />
            </div>
            <div>
              <h1 className="text-lg font-bold tracking-tight text-slate-900 leading-none">Qis Grammar</h1>
              <p className="text-[10px] font-medium text-slate-500 uppercase tracking-tighter">AI Writing Assistant</p>
            </div>
          </div>
        </div>
      </header>

      <main className="pb-20">
        <GrammarChecker />
      </main>
    </div>
  );
}
