//
//  GameListCellView.swift
//  WhoGame
//
//  Created by Иван Маришин on 10.01.2022.
//

import SwiftUI

struct GameListCellView: View {
    
    @EnvironmentObject var gameManager: GameManager
    var game: GameCD
    let symbolType: Bool
    
    var body: some View {
        HStack {
            Group {
                VStack(alignment: .leading, spacing: 3) {
                    if symbolType {
                        Text("\(game.name ?? "Unknown")")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(
                                gameManager.mainColorSheme(color: .red)
                            )
                        Text("Theme: \(game.theme ?? "Unknown")")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)
                        Text("Questions: \(PersistenceController.shared.fetchGameCards(for: game.id ?? "").count)")
                            .font(.system(size: 16, weight: .ultraLight))
                            .foregroundColor(PersistenceController.shared.fetchGameCards(for: game.id ?? "").isEmpty ? .red:.primary)
                    } else {
                        Text("\(game.name ?? "Unknown")")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(
                                gameManager.mainColorSheme(color: .green)
                            )
                        Text("Theme: \(game.theme ?? "Unknown")")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)
                        Text("Date of creation: \(game.date?.longDate ?? "Unknown")")
                            .font(.system(size: 16, weight: .ultraLight))
                    }
                }
            }
            
            Spacer()
            Group {
                if symbolType {
                    Image(systemName: "play")
                        .font(.system(size: 44, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            gameManager.mainColorSheme(color: .red)
                        )
                        .opacity(PersistenceController.shared.fetchGameCards(for: game.id ?? "").isEmpty ? 0.2:1.0)
                } else {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 44, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            gameManager.mainColorSheme(color: .green)
                        )
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
    }
}
