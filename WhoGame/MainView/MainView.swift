//
//  MainView.swift
//  WhoGame
//
//  Created by Иван Маришин on 05.12.2021.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @State var animate = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                BackgroundView()
                VStack(spacing: 16) {
                    Button {
                        withAnimation(.default) {
                            gameManager.leftHande.toggle()
                        }
                    } label: {
                        Text("Hand")
                    }

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
                .navigationBarHidden(true)
            }
//            .animation(.easeInOut(duration: 3).repeatForever(), value: animate)
//            .onAppear {
//                animate = true
//            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(GameManager())
            .preferredColorScheme(.light)
    }
}
