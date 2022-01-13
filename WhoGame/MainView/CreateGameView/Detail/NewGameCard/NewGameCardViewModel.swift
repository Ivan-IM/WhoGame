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
    @Published var fakeAnswerSecond: String = ""
    @Published var fakeAnswerThird: String = ""
    @Published var fakeAnswerFourth: String = ""
    @Published var help: String = ""
    @Published var score: Int = 1
    
    @Published var showingDaleteAlert: Bool = false
    
    var scoreArray = (1...10).map { $0 }
    
    var showingNewCard: Binding<Bool>
    let gameType: Int
    let gameId: String
    let showScore: Bool
    let showHelp: Bool
    
    var gameCard: GameCardCD?
    
    init(showingNewCard: Binding<Bool>, gameType: Int , gameId: String, showScore: Bool, showHelp: Bool) {
        self.showingNewCard = showingNewCard
        self.gameType = gameType
        self.gameId = gameId
        self.showScore = showScore
        self.showHelp = showHelp
    }
    
    init(gameCard: GameCardCD, gameType: Int, showScore: Bool, showHelp: Bool) {
        self.gameCard = gameCard
        self.gameType = gameType
        self.gameId = gameCard.gameId ?? ""
        self.showingNewCard = .constant(false)
        self.showScore = showScore
        self.showHelp = showHelp
        self.question = gameCard.question ?? ""
        self.answer = gameCard.answer ?? ""
        self.fakeAnswerSecond = gameCard.fakeAnswerSecond ?? ""
        self.fakeAnswerThird = gameCard.fakeAnswerThird ?? ""
        self.fakeAnswerFourth = gameCard.fakeAnswerFourth ?? ""
        self.help = gameCard.help ?? ""
        self.score = Int(gameCard.score)
    }
    
    func saveNewGameCard() {
        let gameCard = GameCardCD(context: PersistenceController.shared.container.viewContext)
        gameCard.id = UUID().uuidString
        gameCard.gameId = self.gameId
        gameCard.question = self.question
        gameCard.answer = self.answer
        if gameType == 1 {
            gameCard.fakeAnswerSecond = self.fakeAnswerSecond
        }
        if gameType == 2 {
            gameCard.fakeAnswerSecond = self.fakeAnswerSecond
            gameCard.fakeAnswerThird = self.fakeAnswerThird
            gameCard.fakeAnswerFourth = self.fakeAnswerFourth
        }
        gameCard.score = Int64(self.score)
        gameCard.help = self.help
        gameCard.mark = Int64(PersistenceController.shared.fetchGameCards(for: gameId).count)
        
        guard let game = PersistenceController.shared.fetchGames(for: gameId).first else { return }
        gameCard.toGameCD = game
        
        PersistenceController.shared.save { error in
            switch error {
            case .none:
                print("New gameCard save")
                self.showingNewCard.wrappedValue = false
                self.gameCard = gameCard
            case .some(_):
                print(String(describing: error?.localizedDescription))
            }
        }
    }
    
    func updateGameCard() {
        self.gameCard?.question = self.question
        self.gameCard?.answer = self.answer
        self.gameCard?.score = Int64(self.score)
        self.gameCard?.help = self.help
        if gameType == 1 {
            self.gameCard?.fakeAnswerSecond = self.fakeAnswerSecond
        }
        if gameType == 2 {
            self.gameCard?.fakeAnswerSecond = self.fakeAnswerSecond
            self.gameCard?.fakeAnswerThird = self.fakeAnswerThird
            self.gameCard?.fakeAnswerFourth = self.fakeAnswerFourth
        }
        
        PersistenceController.shared.save { error in
            switch error {
            case .none:
                print("GameCard update")
            case .some(_):
                print(String(describing: error?.localizedDescription))
            }
        }
    }
    
    func deleteGameCard() {
        guard let gameCard = self.gameCard else { return }
        PersistenceController.shared.delete(gameCard)
    }
    
    func isValidForm() -> Bool {
        switch gameType {
        case 1:
            return question.isEmpty || answer.isEmpty || fakeAnswerSecond.isEmpty
        case 2:
            return question.isEmpty || answer.isEmpty || fakeAnswerSecond.isEmpty || fakeAnswerThird.isEmpty || fakeAnswerFourth.isEmpty
        default:
            return question.isEmpty || answer.isEmpty
        }
    }
}
