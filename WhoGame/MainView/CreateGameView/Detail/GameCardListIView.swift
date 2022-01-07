//
//  GameCardListIView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.01.2022.
//

import SwiftUI

struct GameCardListIView: View {
    
    let gameId: String
    var gameCardRequest : FetchRequest<GameCardCD>
    var gameCards : FetchedResults<GameCardCD>{gameCardRequest.wrappedValue}

    init(gameId: String) {
        self.gameId = gameId
        self.gameCardRequest = FetchRequest(entity: GameCardCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GameCardCD.mark, ascending: true)], predicate: NSPredicate(format: "gameId == %@", gameId))
    }
    
    var body: some View {
        List(gameCards) { card in
            HStack {
                Text("\(card.mark).")
                    .fontWeight(.semibold)
                Text("\(card.question ?? "Unknown")")
            }
        }
    }
}

struct GameCardListIView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            GameCardListIView(gameId: "")
        }
    }
}
