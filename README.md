# aya-local-copilot

A local-first AI assistant that enables users to rewrite, translate, and summarize text across any application via a global hotkey — without sending data to the cloud.

---

## 🚀 Overview

Aya Local Copilot is a macOS menu bar application that integrates a locally running LLM (Tiny Aya) to provide instant writing assistance across any app.

Instead of switching between tools (e.g., ChatGPT, Google Translate), users can:

- Select any text
- Trigger a global shortcut
- Instantly transform the text using AI

All processing happens entirely on-device, ensuring privacy and eliminating API costs.

---

## ✨ Features

- Fix grammar while preserving tone  
- Translate between multiple languages  
- Rewrite text in a professional tone  
- Summarize long content into concise insights  
- Global hotkey access (Cmd + Shift + .)  
- macOS menu bar integration  
- 100% local inference (no cloud dependency)

---

## 🎬 Demo

docs/demo.gif

---

## 🧠 Architecture

User selects text  
        ↓  
Global hotkey triggered  
        ↓  
macOS Menu Bar App (Swift)  
        ↓  
Local API (aya-cli)  
        ↓  
Tiny Aya (via llama.cpp)  
        ↓  
Result (popup / clipboard)

---

## 🛠️ Tech Stack

- Frontend (App Layer): Swift / SwiftUI (macOS)
- AI Runtime: aya-cli
- Model: Tiny Aya (multilingual LLM)
- Inference Engine: llama.cpp (via aya-cli)
- Local API: OpenAI-compatible REST endpoint

---

## 🔒 Why Local-First?

Most AI writing tools rely on cloud APIs, which introduces:

- Privacy concerns (data leaves device)
- Ongoing API costs
- Latency from network calls

This project explores a different design:

Local inference + OS-level integration

Benefits:
- Sensitive data never leaves your machine  
- Zero API cost  
- Fast iteration and offline capability  
- Full control over model behavior  

---

## 📦 Setup

### 1. Install aya-cli

Follow the official repo:

https://github.com/Cohere-Labs/aya-cli

---

### 2. Download model

aya-cli install

---

### 3. Start local server

aya-cli serve

This will start a local API at:

http://localhost:8000/v1

---

### 4. Run the macOS app

Open the app/ folder in Xcode and run the project.

---

## ⚙️ Usage

1. Select any text in any application  
2. Press Cmd + Shift + . (global shortcut)  
3. Choose an action:
   - Fix Grammar
   - Translate
   - Rewrite
   - Summarize  
4. View result in popup or copy to clipboard  

---

## 📁 Project Structure

aya-local-copilot/  
├── app/              # macOS menu bar application (Swift)  
├── api-client/       # Local API interaction with aya-cli  
├── docs/             # Demo assets (GIFs, screenshots)  
├── scripts/          # Helper scripts (optional)  
├── README.md  
└── .gitignore  

---

## 🧩 Design Decisions

### Why menu bar instead of full app?
- Faster access
- Always available
- Minimal UI friction

### Why clipboard-based text capture?
- More reliable than Accessibility API
- Works across most applications

### Why Tiny Aya?
- Strong multilingual capability
- Lightweight enough for local inference
- Open and customizable

---

## ⚠️ Limitations

- Performance depends on local hardware (CPU/GPU)
- Small models may struggle with complex reasoning
- Text replacement across all apps is not fully reliable
- Currently macOS only

---

## 🗺️ Future Work

- Direct text replacement (instead of clipboard)
- Custom prompt system (user-defined commands)
- Persistent memory (context-aware rewriting)
- Multi-model support (Llama, Mistral, etc.)
- Performance optimization (streaming, batching)
- Cross-platform support (Windows / Linux)

---

## 🙏 Acknowledgements

This project uses Tiny Aya via aya-cli by Cohere Labs:

https://github.com/Cohere-Labs/aya-cli
