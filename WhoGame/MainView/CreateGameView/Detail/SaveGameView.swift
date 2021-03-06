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
                Spacer()
                Text("\(viewModel.date.longDate)")
            }
            .lineLimit(1)
            .font(.system(size: 16, weight: .ultraLight))
            HStack(spacing: 16) {
                Group {
                    Group {
                        switch viewModel.type {
                        case 1:
                            Image(systemName: "2")
                                .font(.system(size: 22, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    gameManager.mainColorSheme(color: .blue)
                            )
                        case 2:
                            Image(systemName: "4")
                                .font(.system(size: 22, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    gameManager.mainColorSheme(color: .blue)
                            )
                        case 3:
                            Image(systemName: "fork.knife")
                                .font(.system(size: 22, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    gameManager.mainColorSheme(color: .blue)
                            )
                        default:
                            Image(systemName: "message")
                                .font(.system(size: 22, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    gameManager.mainColorSheme(color: .blue)
                            )
                        }
                    }
                    if viewModel.showScore {
                        Image(systemName: "bolt")
                            .font(.system(size: 22, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .green)
                            )
                    } else {
                        Image(systemName: "bolt.slash")
                            .font(.system(size: 22, weight: .regular))
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
                            .font(.system(size: 22, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .green)
                            )
                    } else {
                        Image(systemName: "eye.slash")
                            .font(.system(size: 22, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .red)
                            )
                    }
                }
                Group {
                    if viewModel.showHelp {
                        Image(systemName: "bell")
                            .font(.system(size: 22, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .green)
                            )
                    } else {
                        Image(systemName: "bell.slash")
                            .font(.system(size: 22, weight: .regular))
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
                if PersistenceController.shared.fetchGameCards(for: viewModel.id).count > 1 {
                    Button {
                        viewModel.listEditMode.toggle()
                        viewModel.showingNewCard = false
                    } label: {
                        Image(systemName: "list.bullet")
                            .font(.system(size: 44, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .red)
                            )
                    }
                }
                Button {
                    withAnimation {
                        viewModel.editMode = true
                        viewModel.showingNewCard = false
                        viewModel.editCardMode = false
                    }
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
                    withAnimation {
                        viewModel.showingNewCard = true
                        viewModel.editCardMode = false
                    }
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
                .opacity(viewModel.showingNewCard ? 0.3:1.0)
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
