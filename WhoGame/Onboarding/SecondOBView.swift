//
//  SecondOBView.swift
//  WhoGame
//
//  Created by Иван Маришин on 24.03.2022.
//

import SwiftUI

struct SecondOBView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @State var title: Int = 0
    
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
                case 2:
                    Text("Game history is saved automaticlly.")
                case 3:
                    Text("You can use network features after login (friend system and game sending system).")
                default:
                    Text("Use the Game Creator and make your own game.")
                }
                Spacer()
            }
            .padding()
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                        title = 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
                        title = 2
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                        title = 3
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
