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
            VStack {
                FakeMenuView()
                    .shadow(color: .black.opacity(0.6), radius: 4, x: 4, y: 4)
            }
            
            VStack {
                Text("top")
                Spacer()
            }
            .padding()
            
            VStack {
                Spacer()
                Text("bottom")
            }
            .padding()
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
