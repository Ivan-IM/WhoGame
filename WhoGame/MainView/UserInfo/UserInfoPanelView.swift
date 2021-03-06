//
//  UserInfoView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.02.2022.
//

import SwiftUI

struct UserInfoPanelView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @EnvironmentObject var fbManager: FBManager
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                VStack(spacing: 24) {
                    Button {
                        withAnimation {
                            gameManager.showingUserInfoView = true
                        }
                    } label: {
                        Image(systemName: "person")
                            .font(.system(size: 32, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .purple)
                            )
                    }
                    
                    Button {
                        withAnimation {
                            gameManager.showingFriendsView = true
                        }
                    } label: {
                        ZStack {
                            Image(systemName: "person.2")
                                .font(.system(size: 32, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    gameManager.mainColorSheme(color: .blue)
                                )
                            if fbManager.friendRequests.count > 0 && fbManager.friendRequests.count < 50 {
                                Image(systemName: "\(fbManager.friendRequests.count)")
                                    .font(.system(size: 16, weight: .regular))
                                    .symbolVariant(.circle.fill)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(
                                        Color.black,
                                        Color.yellow
                                    )
                                    .offset(x: 12, y: -12)
                            }
                        }
                    }
                    
                    Button {
                        withAnimation {
                            gameManager.showingMailView = true
                            fbManager.newMail = fbManager.games.count
                        }
                    } label: {
                        ZStack {
                        Image(systemName: "envelope")
                            .font(.system(size: 32, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .green)
                            )
                            if (fbManager.games.count - fbManager.newMail) > 0 && (fbManager.games.count - fbManager.newMail) < 50 {
                                Image(systemName: "\(fbManager.games.count - fbManager.newMail)")
                                    .font(.system(size: 16, weight: .regular))
                                    .symbolVariant(.circle.fill)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(
                                        Color.black,
                                        Color.yellow
                                    )
                                    .offset(x: 12, y: -12)
                            }
                        }
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
                    FBAuth.logout { result in
                        print("Logged out")
                        gameManager.showingUserInfoPanel = false
                        gameManager.offSetX = -gameManager.width
                        fbManager.clearFBmanager()
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
        }
        
    }
}

struct UserInfoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoPanelView()
            .environmentObject(GameManager())
    }
}
