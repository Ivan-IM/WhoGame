//
//  NewGameCardViewModel.swift
//  WhoGame
//
//  Created by Иван Маришин on 09.12.2021.
//

import SwiftUI

final class NewGameCardViewModel: ObservableObject {
    
    @Published var question: String = ""
    @Published var answer: String = ""
    @Published var mark: Int = 1
    
    @Published var showMarkMenu: Bool = false
    
    let markArray = (1...50).map { $0 }
    
    var showingNewCard: Binding<Bool>
    var gameId: String
    init(showingNewCard: Binding<Bool>, gameId: String) {
        self.showingNewCard = showingNewCard
        self.gameId = gameId
    }
    
    func saveNewGameCard() {
        let gameCard = GameCardCD(context: PersistenceController.shared.container.viewContext)
        gameCard.id = UUID().uuidString
        gameCard.gameId = self.gameId
        gameCard.mark = Int64(self.mark)
        gameCard.question = self.question
        gameCard.answer = self.answer
        
        guard let game = PersistenceController.shared.fetchGames(for: gameId).first else { return }
        gameCard.toGameCD = game
        gameCard.gameType = game.type
        
        PersistenceController.shared.save { error in
            switch error {
            case .none:
                print("New gameCard save")
                self.showingNewCard.wrappedValue = false
            case .some(_):
                print(String(describing: error?.localizedDescription))
            }
        }
    }
}
