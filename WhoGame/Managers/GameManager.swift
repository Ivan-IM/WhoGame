//
//  GameManager.swift
//  WhoGame
//
//  Created by Иван Маришин on 09.12.2021.
//

import SwiftUI

final class GameManager: ObservableObject {
    
    @Published var mainColor = Color.mint
    
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    
}
