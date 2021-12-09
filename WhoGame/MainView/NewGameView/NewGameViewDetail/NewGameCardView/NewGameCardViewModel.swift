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
    @Published var mark: Int = 1
    
    @Published var showMarkMenu: Bool = false
    
    let markArray = (1...50).map { $0 }
    
    var showingNewCard: Binding<Bool>
    init(showingNewCard: Binding<Bool>) {
        self.showingNewCard = showingNewCard
    }
}
