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
            ZStack {
                Color.mint.edgesIgnoringSafeArea(.all)
                VStack() {
                    NavigationLink {
                        GameListView(doYouWantToPlay: true)
                    } label: {
                        Text("Play game")
                            .font(.title.bold())
                            .foregroundColor(.primary)
                            .blendMode(.overlay)
                    }
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.secondary)
                        .frame(width: gameManager.width*0.55, height: 3)
                        .blendMode(.overlay)
                    NavigationLink {
                        CreateGameView(viewModel: CreateGameViewModel())
                    } label: {
                        Text("Create a game")
                            .font(.title.bold())
                            .foregroundColor(.primary)
                            .blendMode(.overlay)
                    }
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.secondary)
                        .frame(width: gameManager.width*0.55, height: 3)
                        .blendMode(.overlay)
                    NavigationLink {
                        GameListView(doYouWantToPlay: false)
                    } label: {
                        Text("List of games")
                            .font(.title.bold())
                            .foregroundColor(.primary)
                            .blendMode(.overlay)
                    }
                }
                .frame(width: gameManager.width*0.77, height: gameManager.height*0.3)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                .background(
                Circle()
                    .fill(.indigo)
                    .frame(width: gameManager.height*0.23, height: gameManager.height*0.23)
                    .blendMode(.normal)
                    //.scaleEffect(animate ? 1.0:0.88)
                    //.animation(.easeInOut(duration: 3).repeatForever(), value: animate)
                )
            .navigationBarHidden(true)
            }
        }
        .onAppear {
            withAnimation() {
                animate = true
            }
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
