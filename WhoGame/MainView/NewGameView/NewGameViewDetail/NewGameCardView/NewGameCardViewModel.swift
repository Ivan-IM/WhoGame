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
    
}
