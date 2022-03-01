//
//  GameStageTastyView.swift
//  WhoGame
//
//  Created by Иван Маришин on 15.01.2022.
//

import SwiftUI

struct GameStageTastyView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.gameCards) { card in
                    HStack {
                        switch card.mark {
                        case 1:
                            Image(systemName: "\(card.mark)")
                                .font(.system(size: 44, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    LinearGradient(colors: [.white, .yellow, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                        case 2:
                            Image(systemName: "\(card.mark)")
                                .font(.system(size: 44, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    LinearGradient(colors: [.white, .gray, .gray], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                        case 3:
                            Image(systemName: "\(card.mark)")
                                .font(.system(size: 44, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    LinearGradient(colors: [.white,.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                        default:
                            Image(systemName: "\(card.mark)")
                                .font(.system(size: 44, weight: .regular))
                                .symbolVariant(.circle)
                                .symbolRenderingMode(.palette)
                                .foregroundColor(.secondary)
                        }
                        HStack {
                        Text("\(card.question ?? "Unknown")")
                            .lineLimit(1)
                        Spacer()
                        if card.mark != viewModel.gameCards.count {
                            Button {
                                moveGameCardDown(gameCard: card)
                            } label: {
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 22, weight: .regular))
                                    .symbolVariant(.circle.fill)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(
                                        Color.white.opacity(0.8),
                                        gameManager.mainColorSheme(color: .red)
                                    )
                            }
                        }
                        if card.mark > 1 {
                            Button {
                                moveGameCardUp(gameCard: card)
                            } label: {
                                Image(systemName: "chevron.up")
                                    .font(.system(size: 22, weight: .regular))
                                    .symbolVariant(.circle.fill)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(
                                        Color.white.opacity(0.8),
                                        gameManager.mainColorSheme(color: .red)
                                    )
                            }
                        }
                    }
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.primary)
                    .padding()
                    }
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                }
            }
            Button {
                viewModel.showingTastyAlert = true
            } label: {
                    Image(systemName: "checkmark")
                        .font(.system(size: 88, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            gameManager.mainColorSheme(color: .blue)
                        )
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
            }
        }
        .alert("End tasting?", isPresented: $viewModel.showingTastyAlert) {
            Button("OK", role: .destructive) {
                viewModel.endTastyGame()
            }
            Button("Cancel", role: .cancel) {}
        }
    }
    
    private func moveGameCardUp(gameCard: GameCardCD) {
        viewModel.gameCards[Int(gameCard.mark-2)].mark += 1
        gameCard.mark -= 1
        PersistenceController.shared.save()
        viewModel.gameCards = viewModel.fetchGameCards(game: viewModel.game)
    }
    
    private func moveGameCardDown(gameCard: GameCardCD) {
        viewModel.gameCards[Int(gameCard.mark)].mark -= 1
        gameCard.mark += 1
        PersistenceController.shared.save()
        viewModel.gameCards = viewModel.fetchGameCards(game: viewModel.game)
    }
}

