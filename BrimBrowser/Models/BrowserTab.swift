//
//  BrowserTab.swift
//  BrimBrowser
//
//  Created by Devansh Rai on 17/9/25.
//

import Foundation

final class BrowserTab: Identifiable, ObservableObject {
    let id = UUID()
    @Published var title: String
    @Published var url: String
    var webView: WebViewManager

    init(title: String, url: String, webView: WebViewManager) {
        self.title = title
        self.url = url
        self.webView = webView
    }
}
