//
//  OnboardingView.swift
//  WhoGame
//
//  Created by Иван Маришин on 23.03.2022.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var gameManager: GameManager
    
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
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 34)
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        )
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(GameManager())
    }
}
