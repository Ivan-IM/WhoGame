//
//  NewGameView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.01.2022.
//

import SwiftUI

struct NewGameView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @ObservedObject var viewModel: CreateGameViewModel
    @FocusState private var showingKeyboard: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            TextField("Name", text: $viewModel.name)
                .focused($showingKeyboard)
                .font(.system(size: 18, weight: .semibold))
            RoundedRectangle(cornerRadius: 16)
                .fill(viewModel.name.isEmpty ? gameManager.mainColorSheme(color: .red):gameManager.mainColorSheme(color: .green))
                .frame(height: 2)
            TextField("Theme", text: $viewModel.theme)
                .focused($showingKeyboard)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.secondary)
            RoundedRectangle(cornerRadius: 16)
                .fill(viewModel.theme.isEmpty ? gameManager.mainColorSheme(color: .red):gameManager.mainColorSheme(color: .green))
                .frame(height: 2)
            HStack {
                Text("Date of creation")
                Spacer()
                Text("\(viewModel.date.longDate)")
            }
            .lineLimit(1)
            .font(.system(size: 16, weight: .ultraLight))
            HStack(spacing: 16) {
                Button {
                    viewModel.showScore.toggle()
                } label: {
                    HStack {
                        Text("Scores")
                            .lineLimit(1)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(viewModel.showScore ? .primary:.secondary)
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
                    }
                }
                Spacer()
                Button {
                    viewModel.showAnswer.toggle()
                } label: {
                    HStack {
                        Text("Answers")
                            .lineLimit(1)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(viewModel.showAnswer ? .primary:.secondary)
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
                    }
                }
                Spacer()
                Button {
                    viewModel.showHelp.toggle()
                } label: {
                    HStack {
                        Text("Help")
                            .lineLimit(1)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(viewModel.showHelp ? .primary:.secondary)
                        Group {
                            if viewModel.showHelp {
                                Image(systemName: "bell")
                                    .font(.system(size: 18, weight: .regular))
                                    .symbolVariant(.circle.fill)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(
                                        Color.white.opacity(0.8),
                                        gameManager.mainColorSheme(color: .green)
                                    )
                            } else {
                                Image(systemName: "bell.slash")
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
                }
            }
            HStack {
                Group {
                    if viewModel.id.isEmpty {
                        if viewModel.type == 1 || viewModel.type == 2 {
                            HStack {
                                Button {
                                    viewModel.type = 1
                                } label: {
                                    Image(systemName: "2")
                                        .font(.system(size: 44, weight: .regular))
                                        .symbolVariant(.circle.fill)
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(
                                            Color.white.opacity(0.8),
                                            gameManager.mainColorSheme(color: .blue)
                                        )
                                }
                                .opacity(viewModel.type == 1 ? 1.0:0.3)
                                Button {
                                    viewModel.type = 2
                                } label: {
                                    Image(systemName: "4")
                                        .font(.system(size: 44, weight: .regular))
                                        .symbolVariant(.circle.fill)
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(
                                            Color.white.opacity(0.8),
                                            gameManager.mainColorSheme(color: .blue)
                                        )
                                }
                                .opacity(viewModel.type == 2 ? 1.0:0.3)
                            }
                        }
                    }
                }
                Spacer()
                Group {
                    if viewModel.editMode {
                        HStack {
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
                                viewModel.updateGame()
                                showingKeyboard = false
                            } label: {
                                Image(systemName: "arrow.triangle.2.circlepath")
                                    .font(.system(size: 44, weight: .regular))
                                    .symbolVariant(.circle.fill)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(
                                        Color.white.opacity(0.8),
                                        gameManager.mainColorSheme(color: .green)
                                    )
                            }
                            .opacity(viewModel.isValidForm() ? 0.3:1.0)
                            .disabled(viewModel.isValidForm())
                        }
                    } else {
                        Button {
                            withAnimation {
                                viewModel.saveNewGame(gameManager.uid)
                            }
                            showingKeyboard = false
                        } label: {
                            Image(systemName: "checkmark")
                                .font(.system(size: 44, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    gameManager.mainColorSheme(color: .green)
                                )
                        }
                        .opacity(viewModel.isValidForm() ? 0.3:1.0)
                        .disabled(viewModel.isValidForm())
                    }
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
    }
}

struct NewGameView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameView(viewModel: CreateGameViewModel())
    }
}
