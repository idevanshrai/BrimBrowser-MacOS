//
//  TabManager.swift
//  BrimBrowser
//
//  Created by Devansh Rai on 17/9/25.
//

import Foundation

final class TabManager: ObservableObject {
    @Published var tabs: [BrowserTab] = []
    @Published var currentTab: BrowserTab?
    @Published var addressBarText: String = ""

    init() {
        addTab() // start with one tab open
    }

    func addTab() {
        let webView = WebViewManager()
        let newTab = BrowserTab(title: "Home", url: "", webView: webView)
        tabs.append(newTab)
        currentTab = newTab
        addressBarText = ""
    }

    func closeTab(_ tab: BrowserTab) {
        tabs.removeAll { $0.id == tab.id }
        if currentTab?.id == tab.id {
            currentTab = tabs.last
            addressBarText = currentTab?.url ?? ""
        }
    }

    func switchToTab(_ tab: BrowserTab) {
        currentTab = tab
        addressBarText = tab.url
    }

    func loadCurrent() {
        guard let currentTab = currentTab else { return }
        var input = addressBarText.trimmingCharacters(in: .whitespacesAndNewlines)

        if input.isEmpty {
            return
        }

        // If input looks like a URL (contains a dot or starts with http)
        if input.starts(with: "http://") || input.starts(with: "https://") {
            // valid full URL
        } else if input.contains(".") && !input.contains(" ") {
            input = "https://\(input)"
        } else {
            // Treat as Google search
            let query = input.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? input
            input = "https://www.google.com/search?q=\(query)"
        }

        currentTab.webView.load(input)
        currentTab.url = input
    }
}
