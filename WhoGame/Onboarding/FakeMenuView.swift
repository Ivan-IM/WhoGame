//
//  FakeMenuView.swift
//  WhoGame
//
//  Created by Иван Маришин on 23.03.2022.
//

import SwiftUI

struct FakeMenuView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @State private var animateCreate = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "w")
                        .font(.system(size: 44, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            Color.blue.opacity(0.9)
                        )
                        .scaleEffect(gameManager.onboardingTitle == 4 ? 1.3:1.0)
                        .animation(gameManager.onboardingTitle == 4 ? .easeInOut(duration: 1).repeatForever(autoreverses: true) : .default, value: gameManager.onboardingTitle)
                    Image(systemName: "h")
                        .font(.system(size: 44, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            Color.orange.opacity(0.9)
                        )
                    Image(systemName: "o")
                        .font(.system(size: 44, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            Color.green.opacity(0.9)
                        )
                }
                Spacer()
                
                Image(systemName: "play")
                    .font(.system(size: 88, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        Color.blue
                    )
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                    .offset(x: gameManager.width*0.22)
                    .scaleEffect(gameManager.onboardingTitle == 2 ? 1.2:1.0)
                    .animation(gameManager.onboardingTitle == 2 ? .easeInOut(duration: 1).repeatForever(autoreverses: true) : .default, value: gameManager.onboardingTitle)
                
                
                Image(systemName: "plus")
                    .font(.system(size: 88, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        Color.orange
                    )
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                    .scaleEffect(gameManager.onboardingTitle == 1 ? 1.2:1.0)
                    .animation(gameManager.onboardingTitle == 1 ? .easeInOut(duration: 1).repeatForever(autoreverses: true) : .default, value: gameManager.onboardingTitle)
                
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 88, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        Color.green
                    )
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                    .offset(x: -gameManager.width*0.22)
                    .scaleEffect(gameManager.onboardingTitle == 3 ? 1.2:1.0)
                    .animation(gameManager.onboardingTitle == 3 ? .easeInOut(duration: 1).repeatForever(autoreverses: true) : .default, value: gameManager.onboardingTitle)
            }
            .padding()
        }
        .mask(RoundedRectangle(cornerRadius: 34))
        .scaleEffect(0.7)
        .onAppear {
            withAnimation {
                gameManager.onboardingTitle = 1
            }
        }
    }
}

struct FakeMenuView_Previews: PreviewProvider {
    static var previews: some View {
        FakeMenuView()
            .environmentObject(GameManager())
    }
}
