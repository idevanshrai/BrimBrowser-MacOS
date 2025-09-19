# 🌐 BrimBrowser

BrimBrowser is a modern, lightweight browser for macOS built with **SwiftUI** and **WKWebView**.  
Inspired by Safari, but designed to be minimal, fast, and customizable — with features like tabs, bookmarks, and a polished UI.

---

## ✨ Features

- 🖥️ **macOS Native UI** — built with SwiftUI, optimized for macOS.
- 📑 **Multiple Tabs** — open, close, and switch tabs with smooth animations.
- 🔖 **Bookmarks** — save and quickly access your favorite sites.
- 🔍 **Smart Address Bar**  
  - Enter full URLs (`https://openai.com`)  
  - Or just type a search term → automatically searches Google.
- 🏠 **Custom Homepage**  
  - Gradient background, large search bar, and favorites grid.
- 🚀 **Splash Screen** — animated startup screen for a premium feel.
- 🌈 **Glassy Look** — frosted `.ultraThinMaterial` everywhere for a modern Safari-like aesthetic.

---

## 📸 Screenshots

> *(Add screenshots of your browser here — splash screen, homepage, tab bar, browsing view)*

- Splash Screen  
- Homepage  
- Browsing with Tabs  

---

## 🛠️ Installation

### Prerequisites
- macOS (Ventura or newer recommended)  
- Xcode 15+  
- Swift 5.9+

### Build & Run
1. Clone the repo:
   bash
   git clone https://github.com/idevanshrai/BrimBrowser-MacOS.git
   cd BrimBrowser-MacOS
`

2. Open `BrimBrowser.xcodeproj` in Xcode.
3. Build & Run on macOS (`⌘R`).

---

## 📂 Project Structure

```
BrimBrowser-MacOS/
├─ Managers/
│  └─ TabManager.swift         # Handles tab logic
├─ Models/
│  ├─ BrowserTab.swift         # Tab data model
│  └─ BookmarkManager.swift    # Bookmark storage
├─ Views/
│  ├─ BrowserView.swift        # Main browser UI
│  ├─ HomePage.swift           # Homepage layout
│  ├─ SplashScreen.swift       # Animated splash screen
│  └─ WebViewContainer.swift   # SwiftUI <-> WKWebView bridge
├─ WebViewStore/
│  └─ WebViewManager.swift     # WKWebView state handling
└─ BrimBrowserApp.swift        # App entry point
```

---

## 🚧 Roadmap / Future Features

* [ ] Dynamic tab titles (auto-fetch webpage `<title>`)
* [ ] Download manager
* [ ] Private browsing mode
* [ ] History tracking
* [ ] Light/Dark mode homepage themes
* [ ] Extensions API (long-term)

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!
Feel free to fork the repo and submit pull requests.

---

## 📜 License

This project is licensed under the **MIT License**.
See [LICENSE](LICENSE) for details.

---

## 👤 Author

**Devansh Rai**
