//
//  UserInfoView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.02.2022.
//

import SwiftUI

struct UserInfoView: View {
    
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                VStack(spacing: 24) {
                    Button {
                        withAnimation {
                            gameManager.showingFriendsView = true
                        }
                    } label: {
                        Image(systemName: "person.2")
                            .font(.system(size: 32, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .blue)
                            )
                    }
                    
                    Button {
                        withAnimation {
                            gameManager.showingMailView = true
                        }
                    } label: {
                        Image(systemName: "envelope")
                            .font(.system(size: 32, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .green)
                            )
                    }
                    
                    Button {
                        gameManager.showingLogoutAlert = true
                    } label: {
                        Image(systemName: "figure.walk")
                            .font(.system(size: 32, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .red)
                            )
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: 34)
                    .fill(.secondary)
                    .opacity(0.8)
                    .ignoresSafeArea()
            )
            HStack {
                Spacer()
                RoundedRectangle(cornerRadius: 8)
                    .fill(.ultraThinMaterial)
                    .frame(width: 6, height: 100)
            }
            .padding(10)
            .alert("Logout", isPresented: $gameManager.showingLogoutAlert) {
                Button("OK", role: .destructive) {
                    gameManager.showingUserInfo = false
                    gameManager.offSetX = -gameManager.width
                }
                Button("Cancel", role: .cancel) {}
            }
        }
        
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
            .environmentObject(GameManager())
    }
}
