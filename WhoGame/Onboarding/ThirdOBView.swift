//
//  ThirdOBView.swift
//  WhoGame
//
//  Created by Иван Маришин on 27.03.2022.
//

import SwiftUI

struct ThirdOBView: View {
    
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        VStack(spacing: 16) {
            Image("logo")
                .resizable()
                .frame(width: gameManager.width*0.7, height: gameManager.width*0.7)
            
        }
    }
}

struct ThirdOBView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdOBView()
            .environmentObject(GameManager())
    }
}
