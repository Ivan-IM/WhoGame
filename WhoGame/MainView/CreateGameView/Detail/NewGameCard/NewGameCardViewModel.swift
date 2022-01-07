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
    @Published var score: Int = 1
    
    var scoreArray = (1...10).map { $0 }
    
    var showScore: Bool
    var showingNewCard: Binding<Bool>
    var gameId: String
    init(showingNewCard: Binding<Bool>, gameId: String, showScore: Bool) {
        self.showingNewCard = showingNewCard
        self.gameId = gameId
        self.showScore = showScore
    }
    
    func saveNewGameCard() {
        let gameCard = GameCardCD(context: PersistenceController.shared.container.viewContext)
        gameCard.id = UUID().uuidString
        gameCard.gameId = self.gameId
        gameCard.question = self.question
        gameCard.answer = self.answer
        
        guard let game = PersistenceController.shared.fetchGames(for: gameId).first else { return }
        gameCard.toGameCD = game
        
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
