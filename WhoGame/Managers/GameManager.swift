//
//  GameManager.swift
//  WhoGame
//
//  Created by Иван Маришин on 09.12.2021.
//

import SwiftUI

final class GameManager: ObservableObject {
    
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    
    @Published var leftHande: Bool {
        didSet {
            UserDefaults.standard.set(leftHande, forKey: "Hande")
        }
    }
    
    @Published var showingPrivacy: Bool = false
    @Published var showingUserInfoPanel: Bool = false
    @Published var offSetX: CGFloat = 0
    
    @Published var showingUserInfoView: Bool = false
    @Published var showingFriendsView: Bool = false
    @Published var showingMailView: Bool = false
    @Published var showingLogoutAlert: Bool = false
    
    
    
    enum ColorSchemeEnum {
        case red, green, blue, purple
    }
    
    init() {
        self.leftHande = UserDefaults.standard.object(forKey: "Hande") as? Bool ?? false
        self.offSetX = -self.width
    }
    
    func mainColorSheme(color: ColorSchemeEnum) -> LinearGradient {
        switch color {
        case .red:
            return LinearGradient(colors: [Color.red, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .green:
            return LinearGradient(colors: [Color.mint, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .blue:
            return LinearGradient(colors: [Color.teal, Color.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .purple:
            return LinearGradient(colors: [Color.indigo, Color.purple], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
    
}
