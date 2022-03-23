//
//  FakeMenuView.swift
//  WhoGame
//
//  Created by Иван Маришин on 23.03.2022.
//

import SwiftUI

struct FakeMenuView: View {
    
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "w")
                        .font(.system(size: 44, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            gameManager.mainColorSheme(color: .green)
                        )
                    Image(systemName: "h")
                        .font(.system(size: 44, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            gameManager.mainColorSheme(color: .red)
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
                Spacer()
                
                Image(systemName: "play")
                    .font(.system(size: 88, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        gameManager.mainColorSheme(color: .blue)
                    )
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                    .offset(x: gameManager.width*0.22)
                
                
                Image(systemName: "plus")
                    .font(.system(size: 88, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        gameManager.mainColorSheme(color: .red)
                    )
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 88, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        gameManager.mainColorSheme(color: .green)
                    )
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                    .offset(x: -gameManager.width*0.22)
            }
            .padding()
        }
    }
}

struct FakeMenuView_Previews: PreviewProvider {
    static var previews: some View {
        FakeMenuView()
            .environmentObject(GameManager())
    }
}
