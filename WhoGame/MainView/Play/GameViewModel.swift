//
//  GameViewModel.swift
//  WhoGame
//
//  Created by Иван Маришин on 09.01.2022.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    
    @Published var player: String = ""
    @Published var gameType: Int = 0
    @Published var gameCards = [GameCardCD]()
    @Published var score: Int = 0
    @Published var answer: String = ""
    @Published var index: Int = 0
    @Published var answerSystem: CheckAnswerSystem = .text
    @Published var stageSystem: CheckStageSystem = .start
    @Published var rulesSystem: AboutRules = .name
    
    @Published var showingExitAlert: Bool = false
    
    var game: GameCD
    
    enum CheckAnswerSystem {
        case right, wrong, text
    }
    
    enum CheckStageSystem {
        case start, game, end
    }
    
    enum AboutRules {
        case name, scoreOn, scoreOff, answerOn, answerOff
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
    
    func checkAnswer() -> CheckAnswerSystem {
        if let answer = self.gameCards[self.index].answer {
            if self.answer == answer {
                return .right
            } else {
                return .wrong
            }
        } else {
            return .text
        }
    }
    
    func checkStage() -> CheckStageSystem {
        if self.index < (self.gameCards.count - 1) {
            self.index += 1
            return .game
        } else {
            return .end
        }
    }
    
    func nextCard() {
        if self.answerSystem == .right {
            self.score += Int(self.gameCards[self.index].score)
        }
        self.answer = ""
        self.answerSystem = .text
        self.stageSystem = checkStage()
    }
    
    func clearGame() {
        self.answer = ""
        self.answerSystem = .text
        self.index = 0
        self.score = 0
        self.stageSystem = .start
    }
    
    func isValidForm() -> Bool {
        return answer.isEmpty
    }
}
