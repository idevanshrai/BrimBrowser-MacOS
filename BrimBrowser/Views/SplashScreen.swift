//
//  Untitled.swift
//  BrimBrowser
//
//  Created by Devansh Rai on 17/9/25.
//

import SwiftUI

struct SplashScreen: View {
    @State private var scale: CGFloat = 0.6
    @State private var opacity: Double = 0.0

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Image(systemName: "safari.fill") // Replace with your app logo
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundStyle(.white)
                    .scaleEffect(scale)
                    .opacity(opacity)

                Text("Brim Browser")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .opacity(opacity)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                scale = 1.0
                opacity = 1.0
            }
        }
    }
}
