//
//  GameMenuView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.02.2022.
//

import SwiftUI

struct GameMenuView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @State var animateOne = true
    @State var animateTwo = true
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                VStack(spacing: 16) {
                    HStack {
                        Button {
                            if gameManager.skipSignIn {
                                withAnimation {
                                    gameManager.skipSignIn = false
                                }
                            } else {
                                withAnimation {
                                    gameManager.showingUserInfoPanel.toggle()
                                    if gameManager.showingUserInfoPanel {
                                        gameManager.offSetX = -gameManager.width+56
                                    } else {
                                        gameManager.offSetX = -gameManager.width
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: animateOne ? "gear":"w")
                                .font(.system(size: 44, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    gameManager.mainColorSheme(color: gameManager.leftHande ? .blue:.green)
                                )
                        }
                        
                        Image(systemName: "h")
                            .font(.system(size: 44, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .red)
                            )
                        Button {
                            withAnimation(.default) {
                                gameManager.leftHande.toggle()
                            }
                        } label: {
                            Image(systemName: animateTwo ? "hand.raised":"o")
                                .font(.system(size: 44, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    gameManager.mainColorSheme(color: gameManager.leftHande ? .green:.blue)
                                )
                        }
                    }
                    
                    Spacer()
                    NavigationLink {
                        GameListView()
                            .onAppear {
                                gameManager.showingUserInfoPanel = false
                                gameManager.offSetX = -gameManager.width+56
                            }
                    } label: {
                        Image(systemName: "play")
                            .font(.system(size: 88, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .blue)
                            )
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                    }
                    .offset(x: gameManager.leftHande ? -gameManager.width*0.22:gameManager.width*0.22)
                    NavigationLink {
                        CreateGameView(viewModel: CreateGameViewModel())
                            .onAppear {
                                gameManager.showingUserInfoPanel = false
                                gameManager.offSetX = -gameManager.width+56
                            }
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 88, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .red)
                            )
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                    }
                    NavigationLink {
                        GameHistoryView()
                            .onAppear {
                                gameManager.showingUserInfoPanel = false
                                gameManager.offSetX = -gameManager.width+56
                            }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 88, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .green)
                            )
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                    }
                    .offset(x: gameManager.leftHande ? gameManager.width*0.22:-gameManager.width*0.22)
                }
                .padding()
            }
            .navigationBarHidden(true)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        animateOne = false
                        animateTwo = false
                    }
                }
            }
        }
    }
}


struct GameMenuView_Previews: PreviewProvider {
    static var previews: some View {
        GameMenuView()
            .environmentObject(GameManager())
            .preferredColorScheme(.light)
    }
}
