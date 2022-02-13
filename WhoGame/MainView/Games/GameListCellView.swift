//
//  GameListCellView.swift
//  WhoGame
//
//  Created by Иван Маришин on 10.01.2022.
//

import SwiftUI

struct GameListCellView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @EnvironmentObject var fbManager: FBManager
    @State var isFavorite: Bool = false
    @State var showingDaleteAlert: Bool = false
    let game: GameCD
    let symbolType: Bool
    
    var body: some View {
        HStack {
            Group {
                VStack(alignment: .leading, spacing: 3) {
                    if symbolType {
                        Text("\(game.name ?? "Unknown")")
                            .lineLimit(1)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(
                                gameManager.mainColorSheme(color: .blue)
                            )
                        Text("Theme: \(game.theme ?? "Unknown")")
                            .lineLimit(1)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)
                        switch game.type {
                        case 3:
                            Text("Positions: \(PersistenceController.shared.fetchGameCards(for: game.id ?? "").count)")
                                .lineLimit(1)
                                .font(.system(size: 16, weight: .ultraLight))
                                .foregroundColor(PersistenceController.shared.fetchGameCards(for: game.id ?? "").isEmpty ? .red:.primary)
                        default:
                            Text("Questions: \(PersistenceController.shared.fetchGameCards(for: game.id ?? "").count)")
                                .lineLimit(1)
                                .font(.system(size: 16, weight: .ultraLight))
                                .foregroundColor(PersistenceController.shared.fetchGameCards(for: game.id ?? "").isEmpty ? .red:.primary)
                        }
                        
                    } else {
                        Text("\(game.name ?? "Unknown")")
                            .lineLimit(1)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(
                                gameManager.mainColorSheme(color: .red)
                            )
                        Text("Theme: \(game.theme ?? "Unknown")")
                            .lineLimit(1)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)
                        Text("Date of creation: \(game.date?.longDate ?? "Unknown")")
                            .lineLimit(1)
                            .font(.system(size: 16, weight: .ultraLight))
                            .foregroundColor(.primary)
                    }
                }
            }
            
            Spacer()
            
            Group {
                if symbolType {
                    HStack {
                        if isFavorite {
                            Image(systemName: "star")
                                .font(.system(size: 24, weight: .regular))
                                .symbolVariant(.fill)
                                .foregroundColor(.yellow)
                        }
                        NavigationLink {
                            GameView(viewModel: GameViewModel(game: game))
                        } label: {
                            Image(systemName: "play")
                                .font(.system(size: 44, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    gameManager.mainColorSheme(color: .blue)
                                )
                        }
                        .opacity(PersistenceController.shared.fetchGameCards(for: game.id ?? "").isEmpty ? 0.2:1.0)
                        .disabled(PersistenceController.shared.fetchGameCards(for: game.id ?? "").isEmpty ? true:false)
                    }
                } else {
                    HStack {
                        VStack(spacing: 8) {
                            Button {
                                if isFavorite {
                                    game.favorite = false
                                    PersistenceController.shared.save { error in
                                        switch error {
                                        case .none:
                                            print("Game is not favorite")
                                            self.isFavorite = false
                                        case .some(_):
                                            print(String(describing: error?.localizedDescription))
                                        }
                                    }
                                } else {
                                    game.favorite = true
                                    PersistenceController.shared.save { error in
                                        switch error {
                                        case .none:
                                            print("Game is favorite")
                                            self.isFavorite = true
                                        case .some(_):
                                            print(String(describing: error?.localizedDescription))
                                        }
                                    }
                                }
                            } label: {
                                Image(systemName: "star")
                                    .font(.system(size: 24, weight: .regular))
                                    .symbolVariant(isFavorite ? .fill:.none)
                                    .foregroundColor(isFavorite ? .yellow:.secondary)
                            }
                            
                            NavigationLink {
                                FriendMailView(viewModel: FriendMailViewModel(game: game))
                            } label: {
                                Image(systemName: "envelope")
                                    .font(.system(size: 24, weight: .regular))
                                    .symbolVariant(.circle.fill)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(
                                        Color.white.opacity(0.8),
                                        gameManager.mainColorSheme(color: .blue)
                                    )
                            }
                        }
                        if game.author == fbManager.uid {
                            NavigationLink {
                                CreateGameView(viewModel: CreateGameViewModel(game: game))
                            } label: {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 44, weight: .regular))
                                    .symbolVariant(.circle.fill)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(
                                        Color.white.opacity(0.8),
                                        gameManager.mainColorSheme(color: .red)
                                    )
                            }
                        } else {
                            ZStack {
                                Image(systemName: "eye.slash")
                                    .font(.system(size: 44, weight: .regular))
                                    .symbolVariant(.circle.fill)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(
                                        Color.white.opacity(0.8),
                                        gameManager.mainColorSheme(color: .green)
                                )
                                Button {
                                    showingDaleteAlert = true
                                } label: {
                                    Image(systemName: "trash")
                                        .font(.system(size: 22, weight: .regular))
                                        .symbolVariant(.circle.fill)
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(
                                            Color.white.opacity(0.8),
                                            gameManager.mainColorSheme(color: .red)
                                    )
                                }
                                .offset(x: 15, y: -15)
                                .alert("Delete game?", isPresented: $showingDaleteAlert) {
                                    Button("OK", role: .destructive) {
                                        fbManager.deleteGame(game: game)
                                    }
                                    Button("Cancel", role: .cancel) {}
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
    }
}
