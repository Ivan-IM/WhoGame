//
//  GameViewModel.swift
//  WhoGame
//
//  Created by Иван Маришин on 09.01.2022.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    
    @Published var player: String = ""
    @Published var score: Int = 0
    @Published var rightAnswers: Int = 0
    @Published var index: Int = 0
    
    @Published var answer: String = ""
    @Published var gameCards = [GameCardCD]()
    @Published var answersHystory = [String]()
    @Published var rightAnswersHystory = [String]()
    @Published var answers = [String]()
    @Published var isFavorite: Bool = false
    
    @Published var answerSystem: CheckAnswerSystem = .text
    @Published var stageSystem: CheckStageSystem = .start
    @Published var rulesSystem: AboutRules = .name
    
    @Published var showingExitAlert: Bool = false
    @Published var showingHelpAlert: Bool = false
    @Published var showingTastyAlert: Bool = false
    
    var game: GameCD
    
    enum CheckAnswerSystem {
        case right, wrong, text
    }
    
    enum CheckStageSystem {
        case start, game, end
    }
    
    enum AboutRules {
        case name, scoreOn, scoreOff, answerOn, answerOff, helpOn, helpOff, classic, test2, test4, tasty
    }
    
    init(game: GameCD) {
        self.game = game
        self.gameCards = fetchGameCards(game: game)
        self.isFavorite = game.favorite
    }
    
    func saveGameHistory() {
        let gameHystory = GameHistoryCD(context: PersistenceController.shared.container.viewContext)
        gameHystory.id = UUID().uuidString
        gameHystory.player = self.player
        gameHystory.date = Date()
        switch self.game.type {
        case 3:
            gameHystory.answersHistory = self.answersHystory
        default:
            gameHystory.showScore = self.game.showScore
            gameHystory.answersHistory = self.answersHystory
            gameHystory.rightAnswersHistory = self.rightAnswersHystory
            gameHystory.rightAnswers = Int64(self.rightAnswers)
            gameHystory.questions = Int64(self.gameCards.count)
            gameHystory.score = Int64(self.score)
        }
        gameHystory.gameName = self.game.name ?? "Unknown"
        gameHystory.gameType = self.game.type
        gameHystory.gameId = self.game.id
                
        PersistenceController.shared.save { error in
            switch error {
            case .none:
                print("Game history save")
                self.stageSystem = .end
            case .some(_):
                print(String(describing: error?.localizedDescription))
            }
        }
    }
    
    func updateGameFavorite() {
        guard let game = PersistenceController.shared.fetchGames(for: game.id ?? "").first else { return }
        if isFavorite {
            game.favorite = false
            PersistenceController.shared.save { error in
                switch error {
                case .none:
                    print("Game is not favorite")
                    self.isFavorite = false
                case .some(_):
                    print(String(describing: error?.localizedDescription))
                }
            }
        } else {
            game.favorite = true
            PersistenceController.shared.save { error in
                switch error {
                case .none:
                    print("Game is favorite")
                    self.isFavorite = true
                case .some(_):
                    print(String(describing: error?.localizedDescription))
                }
            }
        }
    }
    
    func fetchGameCards(game: GameCD) -> [GameCardCD] {
        if let gameId = game.id {
            return PersistenceController.shared.fetchGameCards(for: gameId)
        } else {
            return []
        }
    }
    
    func getAnswers() -> [String] {
        var answersArray = [String]()
        if game.type == 1 {
            answersArray.append(contentsOf: [gameCards[index].answer ?? "Unknown", gameCards[index].fakeAnswerSecond ?? "Unknown"])
            return answersArray.shuffled()
        } else {
            answersArray.append(contentsOf: [gameCards[index].answer ?? "Unknown", gameCards[index].fakeAnswerSecond ?? "Unknown", gameCards[index].fakeAnswerThird ?? "Unknown", gameCards[index].fakeAnswerFourth ?? "Unknown"])
            return answersArray.shuffled()
        }
    }
    
    func checkAnswer() -> CheckAnswerSystem {
        if let answer = self.gameCards[self.index].answer {
            if self.answer.caseInsensitiveCompare(answer) == .orderedSame {
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
            self.answers = getAnswers()
            self.stageSystem = .game
        } else {
            self.rightAnswersHystory = self.gameCards.compactMap { $0.answer }
            saveGameHistory()
        }
    }
    
    func endTastyGame() {
        self.answersHystory = self.gameCards.compactMap { $0.answer }
        saveGameHistory()
    }
    
    func nextCard() {
        if self.answerSystem == .right {
            self.rightAnswers += 1
            self.score += Int(self.gameCards[self.index].score)
        }
        self.answersHystory.append(self.answer)
        self.answer = ""
        self.answerSystem = .text
        checkStage()
    }
    
    func clearGame() {
        self.player = ""
        self.answer = ""
        self.answers.removeAll()
        self.answersHystory.removeAll()
        self.rightAnswersHystory.removeAll()
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
