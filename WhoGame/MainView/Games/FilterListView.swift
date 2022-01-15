//
//  FilterListView.swift
//  WhoGame
//
//  Created by Иван Маришин on 12.01.2022.
//

import SwiftUI

struct FilterListView: View {
    
    var doYouWantToPlay: Bool
    var isFavorite: Bool
    var showingSearch: Bool
    
    var gameRequest: FetchRequest<GameCD>
    var games: FetchedResults<GameCD>{gameRequest.wrappedValue}
    
    init(searchText: String, doYouWantToPlay: Bool, isFavorite: Bool, showingSearch: Bool) {
        if searchText.isEmpty {
            self.gameRequest = FetchRequest(entity: GameCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GameCD.date, ascending: false)])
        } else {
            self.gameRequest = FetchRequest(entity: GameCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GameCD.date, ascending: false)], predicate: NSPredicate(format: "name CONTAINS %@", searchText))
        }
        self.doYouWantToPlay = doYouWantToPlay
        self.isFavorite = isFavorite
        self.showingSearch = showingSearch
    }
    
    var body: some View {
        Group {
            if isFavorite {
                ScrollView(showsIndicators: false) {
                    ForEach(games) { game in
                        if game.favorite {
                            if doYouWantToPlay {
                                NavigationLink {
                                    GameView(viewModel: GameViewModel(game: game))
                                } label: {
                                    GameListCellView(isFavorite: game.favorite, game: game, symbolType: doYouWantToPlay)
                                }
                                .disabled(PersistenceController.shared.fetchGameCards(for: game.id ?? "").isEmpty ? true:false)
                            } else {
                                NavigationLink {
                                    CreateGameView(viewModel: CreateGameViewModel(game: game))
                                } label: {
                                    GameListCellView(isFavorite: game.favorite, game: game, symbolType: doYouWantToPlay)
                                }
                            }
                        }
                    }
                }
            } else {
                ScrollView(showsIndicators: false) {
                    ForEach(games) { game in
                        if doYouWantToPlay {
                            NavigationLink {
                                GameView(viewModel: GameViewModel(game: game))
                            } label: {
                                GameListCellView(isFavorite: game.favorite, game: game, symbolType: doYouWantToPlay)
                            }
                            .disabled(PersistenceController.shared.fetchGameCards(for: game.id ?? "").isEmpty ? true:false)
                        } else {
                            NavigationLink {
                                CreateGameView(viewModel: CreateGameViewModel(game: game))
                            } label: {
                                GameListCellView(isFavorite: game.favorite, game: game, symbolType: doYouWantToPlay)
                            }
                        }
                    }
                }
            }
        }
    }
}
