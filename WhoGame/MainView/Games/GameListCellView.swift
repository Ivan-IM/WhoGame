//
//  GameListCellView.swift
//  WhoGame
//
//  Created by Иван Маришин on 10.01.2022.
//

import SwiftUI

struct GameListCellView: View {
    
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
                                LinearGradient(colors: [Color.red, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                        Text("Theme: \(game.theme ?? "Unknown")")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)
                        Text("Questions: \(PersistenceController.shared.fetchGameCards(for: game.id ?? "").count)")
                            .font(.system(size: 16, weight: .ultraLight))
                    } else {
                        Text("\(game.name ?? "Unknown")")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(
                                LinearGradient(colors: [Color.indigo, Color.mint], startPoint: .topLeading, endPoint: .bottomTrailing)
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
                        .imageScale(.large)
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            LinearGradient(colors: [Color.orange, Color.purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                } else {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 44, weight: .regular))
                        .imageScale(.large)
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            LinearGradient(colors: [Color.mint, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
        .padding(.horizontal)
    }
}
