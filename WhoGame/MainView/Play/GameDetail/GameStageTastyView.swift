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
            ScrollView {
                ForEach(viewModel.gameCards) { card in
                    HStack {
                        Image(systemName: "\(card.mark)")
                            .font(.system(size: 44, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .green)
                            )
                        HStack {
                        Text("\(card.question ?? "Unknown")")
                            .lineLimit(1)
                        Spacer()
                        if card.mark != viewModel.gameCards.count {
                            Button {
                                moveGameCardDown(gameCard: card)
                            } label: {
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 18, weight: .regular))
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
                                    .font(.system(size: 18, weight: .regular))
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

