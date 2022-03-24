//
//  FirstOBView.swift
//  WhoGame
//
//  Created by Иван Маришин on 24.03.2022.
//

import SwiftUI

struct FirstOBView: View {
    
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        VStack(spacing: 16) {
            Image("logo")
                .resizable()
                .frame(width: gameManager.width*0.7, height: gameManager.width*0.7)
            HStack(spacing: 3) {
                Image(systemName: "h")
                    .font(.system(size: 44, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        gameManager.mainColorSheme(color: .blue)
                    )
                
                Image(systemName: "e")
                    .font(.system(size: 44, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        gameManager.mainColorSheme(color: .green)
                    )
                
                Image(systemName: "l")
                    .font(.system(size: 44, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        gameManager.mainColorSheme(color: .red)
                    )
                
                Image(systemName: "l")
                    .font(.system(size: 44, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        gameManager.mainColorSheme(color: .green)
                    )
                
                Image(systemName: "o")
                    .font(.system(size: 44, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        gameManager.mainColorSheme(color: .blue)
                    )
            }
        }
    }
}

struct FirstOBView_Previews: PreviewProvider {
    static var previews: some View {
        FirstOBView()
            .environmentObject(GameManager())
    }
}
