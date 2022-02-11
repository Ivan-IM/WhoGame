//
//  UserInfoView.swift
//  WhoGame
//
//  Created by Иван Маришин on 11.02.2022.
//

import SwiftUI

struct UserInfoView: View {
    
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("User")
                        .lineLimit(1)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(
                            gameManager.mainColorSheme(color: .purple)
                        )
                    Spacer()
                    Button {
                        withAnimation {
                            gameManager.showingUserInfoView = false
                        }
                    } label: {
                        Image(systemName: "multiply.circle")
                            .font(.system(size: 32, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .blue)
                            )
                    }
                }
                Spacer()
            }
            .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 34)
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        )
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
            .environmentObject(GameManager())
    }
}
