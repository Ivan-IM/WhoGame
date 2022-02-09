//
//  CreateGameViewModel.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.01.2022.
//

import SwiftUI

final class CreateGameViewModel: ObservableObject {
    
    @Published var name = String()
    @Published var theme = String()
    @Published var date = Date()
    @Published var type: Int = 0
    @Published var id = String()
    @Published var showScore: Bool = false
    @Published var showAnswer: Bool = false
    @Published var showHelp: Bool = false
    
    @Published var editMode: Bool = false
    @Published var listEditMode: Bool = false
    @Published var saveGame: Bool = false
    @Published var showingNewCard: Bool = false
    
    @Published var showingDaleteAlert: Bool = false
    
    init() { }
    
    init(game: GameCD) {
        self.saveGame = true
        self.name = game.name ?? "Unknown"
        self.theme = game.theme ?? "Unknown"
        self.date = game.date ?? Date()
        self.type = Int(game.type)
        self.id = game.id ?? ""
        self.showScore = game.showScore
        self.showAnswer = game.showAnswer
        self.showHelp = game.showHelp
    }
    
    func saveNewGame(_ uid: String) {
        tastyGameBlock()
        let game = GameCD(context: PersistenceController.shared.container.viewContext)
        game.id = UUID().uuidString
        game.name = self.name
        game.theme = self.theme
        game.date = self.date
        game.type = Int64(self.type)
        game.showScore = self.showScore
        game.showAnswer = self.showAnswer
        game.showHelp = self.showHelp
        game.author = uid
        
        PersistenceController.shared.save { error in
            switch error {
            case .none:
                print("New game save")
                self.id = game.id ?? ""
                self.saveGame = true
                self.showingNewCard = true
            case .some(_):
                print(String(describing: error?.localizedDescription))
            }
        }
    }
    
    func updateGame() {
        tastyGameBlock()
        guard let game = PersistenceController.shared.fetchGames(for: id).first else { return }
        game.name = self.name
        game.theme = self.theme
        game.showScore = self.showScore
        game.showAnswer = self.showAnswer
        game.showHelp = self.showHelp
        
        PersistenceController.shared.save { error in
            switch error {
            case .none:
                print("Game update")
                self.editMode = false
            case .some(_):
                print(String(describing: error?.localizedDescription))
            }
        }
    }
    
    func clearGame() {
        self.name = ""
        self.theme = ""
        self.type = 0
        self.id = ""
        self.date = Date()
        self.showScore = false
        self.showAnswer = false
        self.showHelp = false
        self.editMode = false
        self.saveGame = false
        self.showingNewCard = false
    }
        
    func deleteGame() {
        guard let game = PersistenceController.shared.fetchGames(for: id).first else { return }
        let gameCards = PersistenceController.shared.fetchGameCards(for: id)
        PersistenceController.shared.delete(game) { error in
            switch error {
            case .none:
                for gameCard in gameCards {
                    PersistenceController.shared.delete(gameCard)
                }
                self.clearGame()
            case .some(_):
                print(String(describing: error?.localizedDescription))
            }
        }
    }
    
    func isValidForm() -> Bool {
        return name.isEmpty || theme.isEmpty
    }
    
    private func tastyGameBlock() {
        if type == 3 {
            self.showScore = false
            self.showAnswer = false
            self.showHelp = false
        }
    }
}
