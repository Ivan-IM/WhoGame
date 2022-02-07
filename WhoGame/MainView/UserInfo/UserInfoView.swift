//
//  UserInfoView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.02.2022.
//

import SwiftUI

struct UserInfoView: View {
    
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        HStack {
            VStack(spacing: 24) {
                
                Image(systemName: "person.2")
                    .font(.system(size: 32, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        gameManager.mainColorSheme(color: .blue)
                    )
                Image(systemName: "envelope")
                    .font(.system(size: 32, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        gameManager.mainColorSheme(color: .green)
                    )
                Image(systemName: "xmark")
                    .font(.system(size: 32, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        gameManager.mainColorSheme(color: .red)
                    )
                Spacer()
                
            }
            Spacer()
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 34)
                .fill(.secondary)
                .ignoresSafeArea()
        )
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
            .environmentObject(GameManager())
    }
}
