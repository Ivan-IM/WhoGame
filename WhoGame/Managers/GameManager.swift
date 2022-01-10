//
//  GameManager.swift
//  WhoGame
//
//  Created by Иван Маришин on 09.12.2021.
//

import SwiftUI

final class GameManager: ObservableObject {
    
    @Published var player: String = ""
    
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    
    enum ColorSchemeEnum {
       case red, green, blue
    }
    
    func mainColorSheme(color: ColorSchemeEnum) -> LinearGradient {
        switch color {
        case .red:
            return LinearGradient(colors: [Color.red, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .green:
            return LinearGradient(colors: [Color.mint, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .blue:
            return LinearGradient(colors: [Color.teal, Color.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}
