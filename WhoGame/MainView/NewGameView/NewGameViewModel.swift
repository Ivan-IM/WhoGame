//
//  NewGameViewModel.swift
//  WhoGame
//
//  Created by Иван Маришин on 09.12.2021.
//

import SwiftUI

final class NewGameViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var gameType: Int = 0
    
    @Published var saveGame: Bool = false
    @Published var showingNewCard: Bool = false
}
