//
//  WebViewManager.swift
//  BrimBrowser
//
//  Created by Devansh Rai on 17/9/25.
//


//
//  WebViewManager.swift
//  BrimBrowser
//
//  Created by Devansh Rai on 10/9/25.
//

import SwiftUI
import WebKit

// Observable store that owns the WKWebView and reports navigation state
final class WebViewManager: NSObject, ObservableObject, WKNavigationDelegate {
    @Published var webView: WKWebView
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false
    @Published var isLoading: Bool = false
    @Published var progress: Double = 0.0

    override init() {
        let config = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: config)
        super.init()
        webView.navigationDelegate = self

        // Observe loading progress
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }

    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }

    // Load a webpage from a given string (auto-fixes if missing "https://")
    func load(_ urlString: String) {
        let fixed = urlString.starts(with: "http") ? urlString : "https://\(urlString)"
        guard let url = URL(string: fixed) else { return }
        webView.load(URLRequest(url: url))
    }

    // Navigation controls
    func goBack() {
        if webView.canGoBack { webView.goBack() }
    }

    func goForward() {
        if webView.canGoForward { webView.goForward() }
    }

    func reload() {
        webView.reload()
    }

    func stopLoading() {
        webView.stopLoading()
    }

    // KVO observer for progress
    override func observeValue(forKeyPath keyPath: String?, of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            DispatchQueue.main.async {
                self.progress = self.webView.estimatedProgress
            }
        }
    }

    // WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        DispatchQueue.main.async {
            self.isLoading = true
            self.canGoBack = webView.canGoBack
            self.canGoForward = webView.canGoForward
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.canGoBack = webView.canGoBack
            self.canGoForward = webView.canGoForward
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.canGoBack = webView.canGoBack
            self.canGoForward = webView.canGoForward
        }
    }
}
