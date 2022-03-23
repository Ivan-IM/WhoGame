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
                            Color.blue.opacity(0.9)
                        )
                    Image(systemName: "h")
                        .font(.system(size: 44, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            Color.orange.opacity(0.9)
                        )
                    Image(systemName: "o")
                        .font(.system(size: 44, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            Color.green.opacity(0.9)
                        )
                }
                Spacer()
                
                Image(systemName: "play")
                    .font(.system(size: 88, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        Color.blue.opacity(0.9)
                    )
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                    .offset(x: gameManager.width*0.22)
                
                
                Image(systemName: "plus")
                    .font(.system(size: 88, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        Color.orange.opacity(0.9)
                    )
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 88, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        Color.green.opacity(0.9)
                    )
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                    .offset(x: -gameManager.width*0.22)
            }
            .padding()
        }
        .mask(RoundedRectangle(cornerRadius: 34))
        .scaleEffect(0.7)
    }
}

struct FakeMenuView_Previews: PreviewProvider {
    static var previews: some View {
        FakeMenuView()
            .environmentObject(GameManager())
    }
}
