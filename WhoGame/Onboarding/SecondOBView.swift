//
//  SecondOBView.swift
//  WhoGame
//
//  Created by Иван Маришин on 24.03.2022.
//

import SwiftUI

struct SecondOBView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @State private var title: Int = 0
    
    var body: some View {
        ZStack {
            VStack {
                FakeMenuView()
                    .shadow(color: .black.opacity(0.6), radius: 4, x: 4, y: 4)
            }
            
            VStack {
                switch title {
                case 1:
                    Text("After creating, you can play it.")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.secondary)
                case 2:
                    Text("Game history is saved automaticlly.")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.secondary)
                case 3:
                    Text("You can use network features after login (friends system and game sending system).")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.secondary)
                default:
                    Text("Use the Game Creator and make your own game.")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding(32)
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
                    title = 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 25) {
                    title = 2
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 35) {
                    title = 3
                    gameManager.disableSkipOnboarding = false
                }
            }
        }
    }
}

struct SecondOBView_Previews: PreviewProvider {
    static var previews: some View {
        SecondOBView()
            .environmentObject(GameManager())
    }
}
