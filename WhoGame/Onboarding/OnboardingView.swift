//
//  OnboardingView.swift
//  WhoGame
//
//  Created by Иван Маришин on 23.03.2022.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @State private var startAnimation = true
    
    var body: some View {
        ZStack {
            switch gameManager.onboardingViewChanger {
            case 1:
                SecondOBView()
                    .transition(.move(edge: .trailing))
                    .animation(.default, value: gameManager.onboardingViewChanger)
                    .zIndex(1)
            default:
                FirstOBView()
                    .transition(.opacity)
                    .animation(.default, value: gameManager.onboardingViewChanger)
                    .zIndex(0)
            }
            
            VStack {
                Spacer ()
                Button {
                    withAnimation {
                        gameManager.onboardingViewChanger += 1
                    }
                } label: {
                    Text("Next")
                        .font(.system(size: 33, weight: .semibold))
                        .foregroundColor(Color.white.opacity(0.8))
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(
                        RoundedRectangle(cornerRadius: 34)
                            .fill(gameManager.mainColorSheme(color: .blue))
                        )
                }
                .opacity(startAnimation ? 0.0:1.0)
                .animation(.easeInOut(duration: 1), value: startAnimation)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 34)
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        )
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    startAnimation = false
                }
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(GameManager())
    }
}
