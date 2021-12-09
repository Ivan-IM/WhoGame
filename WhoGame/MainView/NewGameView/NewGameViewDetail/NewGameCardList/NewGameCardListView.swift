//
//  NewGameCardListView.swift
//  WhoGame
//
//  Created by Иван Маришин on 09.12.2021.
//

import SwiftUI

struct NewGameCardListView: View {
    
    let gameId: String
    var gameCardRequest : FetchRequest<GameCardCD>
    var gameCards : FetchedResults<GameCardCD>{gameCardRequest.wrappedValue}

    init(gameId: String) {
        self.gameId = gameId
        self.gameCardRequest = FetchRequest(entity: GameCardCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GameCardCD.mark, ascending: true)], predicate: NSPredicate(format: "gameId == %@", gameId))
    }
    
    var body: some View {
        ScrollView {
            ForEach(gameCards) { gameCard in
                NewGameCardListCellView(gameCrad: gameCard)
            }
            .padding(.vertical, 8)
        }
    }
}

struct NewGameCardListView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameCardListView(gameId: "")
    }
}
