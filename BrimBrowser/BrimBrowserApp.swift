//
//  BrimBrowserApp.swift
//  BrimBrowser
//
//  Created by Devansh Rai on 10/9/25.
//

import SwiftUI

@main
struct BrimBrowserApp: App {
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplash {
                    SplashScreen()
                } else {
                    BrowserView()
                }
            }
            .onAppear {
                // Auto-dismiss splash after 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeInOut(duration: 0.8)) {
                        showSplash = false
                    }
                }
            }
        }
    }
}

