# Aya — Local AI Copilot for macOS

Turn any text in macOS into AI-enhanced output — instantly, locally, and without leaving your workflow.

Aya is a system-level AI assistant that enables users to rewrite, translate, and summarize text across any application using a global hotkey — powered by a local multilingual model.

Learn more about Tiny Aya: https://cohere.com/blog/cohere-labs-tiny-aya

---

## 🎥 Demo

https://drive.google.com/file/d/1JuajpfD5qvZozoa-_jAfl_jq95zJB6AO/view?usp=sharing

---

## 🧠 Why I Built This

Most AI writing tools today (e.g. Copilot, Grammarly) require:

- switching context between apps  
- repetitive copy/paste workflows  
- sending sensitive data to cloud APIs  

Aya explores a different interaction model:

> AI as a system-layer capability — not just another app.

This is especially important in **privacy-sensitive environments (e.g. B2B, enterprise workflows)** where sending internal content to external APIs is not acceptable.

---

## 🌍 Multilingual by Design (Tiny Aya)

Aya leverages Tiny Aya, a multilingual model developed by Cohere Labs.

Tiny Aya supports **70+ languages**, including many low-resource languages, enabling:

- Cross-language communication  
- Multilingual rewriting  
- Translation without external APIs  

This makes Aya particularly valuable for:

- global teams  
- international operations  
- multilingual product environments  

---

## 🔒 Why Local (B2B Perspective)

Aya is built as a **local-first AI system**, which directly addresses enterprise concerns:

### Privacy & Compliance
- No data leaves the device  
- No third-party API calls  
- Suitable for internal documents, Slack messages, Notion content  

### Cost Control
- No per-token API cost  
- Predictable infrastructure usage  

### Reliability
- Works offline  
- No dependency on external services  

> This design aligns with how many B2B teams evaluate AI adoption:  
> **control, compliance, and predictability over convenience.**

---

## 🚀 Features

- Fix grammar instantly  
- Translate (multilingual, 70+ languages)  
- Rewrite professionally  
- Summarize text  
- Global hotkey (`Cmd + Shift + .`)  
- Works across any app (Notion, Slack, browser, etc.)  
- Fully local inference (Tiny Aya via aya-cli)  

---

## ⚙️ How It Works

1. User selects text in any application  
2. Aya captures the selection via clipboard  
3. Sends request to local AI model (`aya-cli`)  
4. Receives structured output  
5. Replaces or returns improved text  

---

## 🏗️ Architecture
User Selection
↓
Clipboard Capture
↓
macOS Menu Bar App (Swift)
↓
Local API (aya-cli)
↓
Tiny Aya (llama.cpp backend)

---

## 🛠️ Tech Stack

- Swift (macOS menu bar app)  
- aya-cli (local LLM runtime)  
- llama.cpp (model inference engine)  
- Tiny Aya (multilingual model)  

---

## 📦 Setup

### 1. Install aya-cli
https://github.com/Cohere-Labs/aya-cli

### 2. Run local server
aya-cli serve

## 3. Run macOS app
see demo

## 📌 Current Limitations
Clipboard-based interaction (paste simulation)
No UI for mode switching yet
Requires local model setup

## 🚧 Future Work
Direct inline replacement (no paste simulation)
Mode selection UI (rewrite / translate / summarize)
Prompt customization
Memory / personalization layer
Performance optimization for real-time usage
Packaging as installable macOS app

## 🙏 Acknowledgements

This project uses Tiny Aya via aya-cli by Cohere Labs:
https://cohere.com/blog/cohere-labs-tiny-aya
https://github.com/Cohere-Labs/aya-cli
