//
//  GameListView.swift
//  WhoGame
//
//  Created by Иван Маришин on 08.01.2022.
//

import SwiftUI

struct GameListView: View {
    
    @FetchRequest(entity: GameCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GameCD.date, ascending: false)]) var games: FetchedResults<GameCD>
    let doYouWantToPlay: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                ForEach(games) { game in
                    NavigationLink {
                        if doYouWantToPlay {
                            GameView(viewModel: GameViewModel(game: game))
                        } else {
                            CreateGameView(viewModel: CreateGameViewModel(game: game))
                        }
                    } label: {
                        VStack(alignment: .leading, spacing: 3) {
                            Text(game.name ?? "Unknown")
                                .font(.headline)
                            Text("Theme: \(game.theme ?? "Unknown")")
                                .font(.subheadline)
                            if doYouWantToPlay {
                                Text("Questions: \(PersistenceController.shared.fetchGameCards(for: game.id ?? "").count)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            } else {
                                Text("Date of creation: \(game.date?.longDate ?? "Unknown")")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                //.onDelete(perform: removeGame)
            }
            .navigationTitle("Games")
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
