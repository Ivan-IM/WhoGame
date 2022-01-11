//
//  SaveGameView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.01.2022.
//

import SwiftUI

struct SaveGameView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @ObservedObject var viewModel: CreateGameViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.name)
                .lineLimit(1)
                .font(.system(size: 18, weight: .semibold))
            Text("Theme: \(viewModel.theme)")
                .lineLimit(1)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.secondary)
            HStack {
                Text("Date of creation")
                    .lineLimit(1)
                    .font(.system(size: 16, weight: .ultraLight))
                Spacer()
                Text("\(viewModel.date.longDate)")
                    .font(.system(size: 16, weight: .ultraLight))
            }
            HStack(spacing: 16) {
                Group {
                    if viewModel.showScore {
                        Image(systemName: "bolt")
                            .font(.system(size: 18, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .green)
                            )
                    } else {
                        Image(systemName: "bolt.slash")
                            .font(.system(size: 18, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .red)
                            )
                    }
                    
                }
                Group {
                    if viewModel.showAnswer {
                        Image(systemName: "eye")
                            .font(.system(size: 18, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .green)
                            )
                    } else {
                        Image(systemName: "eye.slash")
                            .font(.system(size: 18, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .red)
                            )
                    }
                    
                }
                Spacer()
            }
            HStack {
                Spacer()
                Button {
                    viewModel.showingDaleteAlert = true
                } label: {
                    Image(systemName: "trash")
                        .font(.system(size: 44, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            gameManager.mainColorSheme(color: .red)
                        )
                }
                Button {
                    viewModel.editMode = true
                    viewModel.showingNewCard = false
                } label: {
                    Image(systemName: "pencil")
                        .font(.system(size: 44, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            gameManager.mainColorSheme(color: .blue)
                        )
                }
                Button {
                    viewModel.showingNewCard = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 44, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            gameManager.mainColorSheme(color: .green)
                        )
                }
                .opacity(viewModel.showingNewCard ? 0.2:1.0)
                .disabled(viewModel.showingNewCard)
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
    }
}

struct SaveGameView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            SaveGameView(viewModel: CreateGameViewModel())
        }
    }
}
