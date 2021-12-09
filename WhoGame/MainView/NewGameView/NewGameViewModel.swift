//
//  NewGameViewModel.swift
//  WhoGame
//
//  Created by Иван Маришин on 09.12.2021.
//

import SwiftUI

final class NewGameViewModel: ObservableObject {
    
    @Published var name = String()
    @Published var gameType: Int = 0
    @Published var gameId = String()
    
    @Published var saveGame: Bool = false
    @Published var showingNewCard: Bool = false
    
    func saveNewGame() {
        let game = GameCD(context: PersistenceController.shared.container.viewContext)
        game.id = UUID().uuidString
        game.name = name
        game.type = Int64(gameType)
        
        PersistenceController.shared.save { error in
            switch error {
            case .none:
                print("New game save")
                self.gameId = game.id ?? ""
                self.saveGame = true
                self.showingNewCard = true
            case .some(_):
                print(String(describing: error?.localizedDescription))
            }
        }
    }
}
