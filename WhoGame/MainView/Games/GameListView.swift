//
//  GameListView.swift
//  WhoGame
//
//  Created by Иван Маришин on 08.01.2022.
//

import SwiftUI

struct GameListView: View {
    
    @FetchRequest(entity: GameCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GameCD.date, ascending: false)]) var games: FetchedResults<GameCD>
    @Environment(\.presentationMode) var presentationMode
    let doYouWantToPlay: Bool
    
    var body: some View {
        ZStack {
//            Rectangle()
//                .fill(.ultraThinMaterial)
//                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Group {
                        if doYouWantToPlay {
                            Text("Games")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundStyle(
                                    LinearGradient(colors: [Color.red, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                        } else {
                            Text("Games")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundStyle(
                                    LinearGradient(colors: [Color.indigo, Color.mint], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                        }
                    }
                    Spacer()
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "multiply.circle")
                            .font(.system(size: 24, weight: .regular))
                            .imageScale(.large)
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                LinearGradient(colors: [Color.teal, Color.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                    }
                }
                .padding(.horizontal)
                ScrollView {
                    ForEach(games) { game in
                        NavigationLink {
                            if doYouWantToPlay {
                                GameView(viewModel: GameViewModel(game: game))
                            } else {
                                CreateGameView(viewModel: CreateGameViewModel(game: game))
                            }
                        } label: {
                            GameListCellView(game: game, symbolType: doYouWantToPlay)
                        }
                    }
                }
                .navigationBarHidden(true)
            }
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
        GameListView(doYouWantToPlay: false)
    }
}
