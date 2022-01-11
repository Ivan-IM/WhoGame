//
//  GameViewModel.swift
//  WhoGame
//
//  Created by Иван Маришин on 09.01.2022.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    
    @Published var answers = [String]()
    @Published var player: String = ""
    @Published var gameType: Int = 0
    @Published var gameCards = [GameCardCD]()
    @Published var score: Int = 0
    @Published var rightAnswers: Int = 0
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
    
    func saveGameHistory() {
        let gameHystory = GameHistoryCD(context: PersistenceController.shared.container.viewContext)
        gameHystory.id = UUID().uuidString
        gameHystory.player = self.player
        gameHystory.showScore = self.game.showScore
        gameHystory.date = Date()
        gameHystory.answers = self.answers
        gameHystory.rightAnswers = Int64(self.rightAnswers)
        gameHystory.score = Int64(self.score)
        gameHystory.gameName = self.game.name ?? "Unknown"
        gameHystory.gameId = self.game.id
        
        gameHystory.toGameCD = self.game
        
        PersistenceController.shared.save()
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
    
    func checkStage() {
        if self.index < (self.gameCards.count - 1) {
            self.index += 1
            self.stageSystem = .game
        } else {
            self.stageSystem = .end
        }
    }
    
    func nextCard() {
        if self.answerSystem == .right {
            self.rightAnswers += 1
            self.score += Int(self.gameCards[self.index].score)
        }
        self.answers.append(self.answer)
        self.answer = ""
        self.answerSystem = .text
        checkStage()
    }
    
    func clearGame() {
        if stageSystem == .end {
            saveGameHistory()
        }
        self.player = ""
        self.answer = ""
        self.answers.removeAll()
        self.rightAnswers = 0
        self.index = 0
        self.score = 0
        self.answerSystem = .text
        self.stageSystem = .start
        self.rulesSystem = .name
    }
    
    func isValidForm() -> Bool {
        return answer.isEmpty
    }
}
