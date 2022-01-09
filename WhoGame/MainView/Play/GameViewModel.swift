//
//  GameViewModel.swift
//  WhoGame
//
//  Created by Иван Маришин on 09.01.2022.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    
    @Published var gameCards = [GameCardCD]()
    @Published var score: Int = 0
    @Published var answer: String = ""
    @Published var index: Int = 0
    @Published var answerSystem: checkSystem = .text
    
    @Published var endGame: Bool = false
    
    var game: GameCD
    
    enum checkSystem {
        case right, wrong, text
    }
    
    init(game: GameCD) {
        self.game = game
        self.gameCards = fetchGameCards(game: game)
    }
    
    func fetchGameCards(game: GameCD) -> [GameCardCD] {
        if let gameId = game.id {
            return PersistenceController.shared.fetchGameCards(for: gameId)
        } else {
            return []
        }
    }
    
    func checkAnswer() -> checkSystem {
        if let answer = self.gameCards[self.index].answer {
            if self.answer == answer {
                self.score += Int(self.gameCards[self.index].score)
                return .right
            } else {
                return .wrong
            }
        } else {
            return .text
        }
    }
    
    func nextCard() {
        self.answer.removeAll()
        self.answerSystem = .text
        self.index += 1
        if self.index == self.gameCards.count {
            self.endGame = true
        } else {
            self.endGame = false
        }
    }
    
    func clearGame() {
        self.answer.removeAll()
        self.answerSystem = .text
        self.index = 0
        self.score = 0
        self.endGame = false
    }
    
    func isValidForm() -> Bool {
        return answer.isEmpty
    }
}
