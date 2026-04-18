# Qis Grammar Checker - Web Application

This is the Next.js-based frontend for the Qis Grammar Checker, powered by Google Gemini. 

## 🚀 Getting Started

### 1. Install Dependencies
```bash
bun install
```

### 2. Configure Environment
Create a `.env` file and add your Gemini API Key:
```env
GEMINI_API_KEY=your_api_key_here
```

### 3. Run Development Server
```bash
bun dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

## 🛠️ Features

- **Gemini 3 Integration**: Real-time grammar and style analysis.
- **Split-Pane Layout**: Side-by-side comparison for desktop users.
- **Diff Highlighting**: Visual indicators for AI-suggested improvements.
- **Apply All**: Seamless one-click acceptance of all corrections.

## 🏗️ Architecture

- **`app/`**: Next.js App Router pages and layouts.
- **`components/`**: React components, including shadcn/ui primitives.
- **`lib/`**: Core utilities and Gemini AI service integration.
- **`app/actions.ts`**: Server Actions for handling AI analysis requests.

For more detailed information, please refer to the [root README](../../README.md).
