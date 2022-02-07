//
//  GameMenuView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.02.2022.
//

import SwiftUI

struct GameMenuView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @State var animate = false
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                VStack(spacing: 16) {
                    HStack {
                        Button {
                            withAnimation {
                                gameManager.showingUserInfo.toggle()
                                gameManager.offSetX = 0
                            }
                        } label: {
                            Image(systemName: "w")
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
                            Image(systemName: "o")
                                .font(.system(size: 44, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    gameManager.mainColorSheme(color: gameManager.leftHande ? .green:.blue)
                                )
                        }
                    }
                    .opacity(0.8)
                    
                    Spacer()
                    NavigationLink {
                        GameListView()
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