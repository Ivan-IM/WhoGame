//
//  FriendSendGameListView.swift
//  WhoGame
//
//  Created by Иван Маришин on 12.02.2022.
//

import SwiftUI

struct FriendSendGameListView: View {
    
    @ObservedObject var viewModel: FriendsViewModel
    var isFavorite: Bool
    var showingSearch: Bool
    
    var gameRequest: FetchRequest<GameCD>
    var games: FetchedResults<GameCD>{gameRequest.wrappedValue}
    
    init(searchText: String, isFavorite: Bool, showingSearch: Bool, viewModel: FriendsViewModel) {
        if searchText.isEmpty {
            self.gameRequest = FetchRequest(entity: GameCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GameCD.date, ascending: false)])
        } else {
            self.gameRequest = FetchRequest(entity: GameCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GameCD.date, ascending: false)], predicate: NSPredicate(format: "name CONTAINS %@", searchText))
        }
        self.isFavorite = isFavorite
        self.showingSearch = showingSearch
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            if isFavorite {
                ScrollView(showsIndicators: false) {
                    ForEach(games) { game in
                        if game.favorite {
                            FriendSendGameListCellView(game: game, friendId: viewModel.friendIdSend)
                        }
                    }
                }
            } else {
                ScrollView(showsIndicators: false) {
                    ForEach(games) { game in
                        FriendSendGameListCellView(game: game, friendId: viewModel.friendIdSend)
                    }
                }
            }
        }
    }
}
