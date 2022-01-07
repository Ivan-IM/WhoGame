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
    
    @Published var editMode: Bool = false
    @Published var saveGame: Bool = false
    @Published var showingNewCard: Bool = false
    
    func saveNewGame() {
        let game = GameCD(context: PersistenceController.shared.container.viewContext)
        game.id = UUID().uuidString
        game.name = self.name
        game.theme = self.theme
        game.date = self.date
        game.type = Int64(self.type)
        game.showScore = self.showScore
        game.showAnswer = self.showAnswer
        
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
        guard let game = PersistenceController.shared.fetchGames(for: id).first else { return }
        game.name = self.name
        game.theme = self.theme
        game.showScore = self.showScore
        game.showAnswer = self.showAnswer
        
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
    
    func isValidForm() -> Bool {
        return name.isEmpty
    }
}
