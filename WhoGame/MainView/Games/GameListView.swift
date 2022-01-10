//
//  GameListView.swift
//  WhoGame
//
//  Created by Иван Маришин on 08.01.2022.
//

import SwiftUI

struct GameListView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @FetchRequest(entity: GameCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GameCD.date, ascending: false)]) var games: FetchedResults<GameCD>
    @Environment(\.presentationMode) var presentationMode
    @State var doYouWantToPlay = true
    
    var body: some View {
        ZStack {
            //            Rectangle()
            //                .fill(.ultraThinMaterial)
            //                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Group {
                        if doYouWantToPlay {
                            Text("Play")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundStyle(
                                    gameManager.mainColorSheme(color: .red)
                                )
                        } else {
                            Text("Edit")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundStyle(
                                    gameManager.mainColorSheme(color: .green)
                                )
                        }
                    }
                    Spacer()
                    Button {
                        doYouWantToPlay.toggle()
                    } label: {
                        if doYouWantToPlay {
                            Image(systemName: "line.3.horizontal")
                                .font(.system(size: 32, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    gameManager.mainColorSheme(color: .green)
                                )
                        } else {
                            Image(systemName: "play")
                                .font(.system(size: 32, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    gameManager.mainColorSheme(color: .red)
                                )
                        }
                    }
                    Button {
                        presentationMode.wrappedValue.dismiss()
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
                ScrollView {
                    ForEach(games) { game in
                        if doYouWantToPlay {
                            NavigationLink {
                                GameView(viewModel: GameViewModel(game: game))
                            } label: {
                                GameListCellView(game: game, symbolType: doYouWantToPlay)
                            }
                            .disabled(PersistenceController.shared.fetchGameCards(for: game.id ?? "").isEmpty ? true:false)
                        } else {
                            NavigationLink {
                                CreateGameView(viewModel: CreateGameViewModel(game: game))
                            } label: {
                                GameListCellView(game: game, symbolType: doYouWantToPlay)
                            }
                        }
                    }
                }
                .navigationBarHidden(true)
            }
            .padding()
        }
    }
    
    private func removeGame(at offsets: IndexSet) {
        for index in offsets {
            let game = games[index]
            PersistenceController.shared.delete(game)
            let gameCards = PersistenceController.shared.fetchGameCards(for: game.id ?? "")
            for gameCard in gameCards {
                PersistenceController.shared.delete(gameCard)
            }
        }
    }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView()
    }
}
