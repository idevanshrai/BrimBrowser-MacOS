//
//  WebViewContainer.swift
//  BrimBrowser
//
//  Created by Devansh Rai on 17/9/25.
//
import SwiftUI
import WebKit

#if os(iOS)
struct WebViewContainer: UIViewRepresentable {
    let webView: WKWebView

    func makeUIView(context: Context) -> WKWebView {
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
#elseif os(macOS)
struct WebViewContainer: NSViewRepresentable {
    let webView: WKWebView

    func makeNSView(context: Context) -> WKWebView {
        return webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {}
}
#endif

