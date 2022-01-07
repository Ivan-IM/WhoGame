//
//  EditGameCardViewModel.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.01.2022.
//

import SwiftUI

final class EditGameCardViewModel: ObservableObject {
    
    @Published var question: String = ""
    @Published var answer: String = ""
    @Published var score: Int = 1
    
    var scoreArray = (1...10).map { $0 }
    
    var showScore: Bool
    var gameCard: GameCardCD
    init(gameCard: GameCardCD, showScore: Bool) {
        self.gameCard = gameCard
        self.showScore = showScore
        self.question = gameCard.question ?? "Unknown"
        self.answer = gameCard.answer ?? "Unknown"
        self.score = Int(gameCard.score)
    }
    
    func updateGameCard() {
        self.gameCard.question = self.question
        self.gameCard.answer = self.answer
        self.gameCard.score = Int64(self.score)
        
        PersistenceController.shared.save { error in
            switch error {
            case .none:
                print("GameCard update")
            case .some(_):
                print(String(describing: error?.localizedDescription))
            }
        }
    }
    
    func isValidForm() -> Bool {
        return question.isEmpty || answer.isEmpty
    }
}
