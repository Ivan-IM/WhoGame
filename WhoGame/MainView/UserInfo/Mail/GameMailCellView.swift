//
//  GameMailCellView.swift
//  WhoGame
//
//  Created by Иван Маришин on 09.02.2022.
//

import SwiftUI

struct GameMailCellView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @EnvironmentObject var fbManager: FBManager
    @ObservedObject var viewModel: GameMailViewModel
    @State private var saveGame: Bool = false
    @State private var showingDeleteAlert: Bool = false
    var game: Game
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text("\(game.name)")
                    .lineLimit(1)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(
                        gameManager.mainColorSheme(color: .blue)
                    )
                Text("Theme: \(game.theme)")
                    .lineLimit(1)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.secondary)
                Text("Author: \(game.authorName ?? "Unknown")")
                    .lineLimit(1)
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.secondary)
            }
            Spacer()
            if viewModel.checkGameAdd(game: game) && !saveGame {
                Button {
                    viewModel.addGame(game: game)
                    saveGame = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 32, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            gameManager.mainColorSheme(color: .blue)
                        )
                }
            } else {
                Image(systemName: "checkmark")
                    .font(.system(size: 32, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        gameManager.mainColorSheme(color: .green)
                    )
            }
            
            Button {
                showingDeleteAlert = true
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 32, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        gameManager.mainColorSheme(color: .red)
                    )
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
        .alert("Delete game?", isPresented: $showingDeleteAlert) {
            Button("OK", role: .destructive) {
                viewModel.removeGame(game: game)
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}
