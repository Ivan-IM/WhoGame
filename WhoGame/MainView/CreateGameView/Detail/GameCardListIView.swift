//
//  GameCardListIView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.01.2022.
//

import SwiftUI

struct GameCardListIView: View {
    
    let gameId: String
    let showScore: Bool
    var gameCardRequest : FetchRequest<GameCardCD>
    var gameCards : FetchedResults<GameCardCD>{gameCardRequest.wrappedValue}
    
    init(gameId: String, showScore: Bool) {
        self.gameId = gameId
        self.gameCardRequest = FetchRequest(entity: GameCardCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GameCardCD.mark, ascending: true)], predicate: NSPredicate(format: "gameId == %@", gameId))
        self.showScore = showScore
    }
    
    var body: some View {
        List {
            ForEach(gameCards) { card in
                NavigationLink {
                    EditGameCardView(viewModel: NewGameCardViewModel(gameCard: card, showScore: showScore))
                } label: {
                    HStack {
                        Text("\(card.mark).")
                            .fontWeight(.semibold)
                        Text("\(card.question ?? "Unknown")")
                    }
                }
            }
            .onMove(perform: moveGameCard)
            .onDelete(perform: removeGameCard)
        }
    }
    
    private func moveGameCard(from source: IndexSet, to destination: Int) {
        if source.first! > destination {
            gameCards[source.first!].mark = gameCards[destination].mark - 1
            for i in destination...gameCards.count - 1 {
                gameCards[i].mark = gameCards[i].mark + 1
            }
        }
        if source.first! < destination {
            gameCards[source.first!].mark = gameCards[destination - 1].mark + 1
            for i in 0...destination - 1 {
                gameCards[i].mark = gameCards[i].mark - 1
            }
        }
        PersistenceController.shared.save()
    }
    
    private func removeGameCard(at offsets: IndexSet) {
        for index in offsets {
            let gameCard = gameCards[index]
            PersistenceController.shared.delete(gameCard)
            for card in gameCards {
                if card.mark > index+1 {
                    card.mark -= 1
                    PersistenceController.shared.save()
                }
            }
        }
    }
}

struct GameCardListIView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            GameCardListIView(gameId: "", showScore: true)
        }
    }
}
