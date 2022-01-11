//
//  StartStageView.swift
//  WhoGame
//
//  Created by Иван Маришин on 11.01.2022.
//

import SwiftUI

struct StartStageView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Text("Questions: \(viewModel.gameCards.count)")
                    .lineLimit(1)
                Spacer()
            }
            .font(.system(size: 16, weight: .semibold))
            Spacer()
            Group {
                switch viewModel.rulesSystem {
                case .name:
                    Text("Enter your name")
                case .scoreOn:
                    Text("Score system is on")
                case .scoreOff:
                    Text("Score system is off")
                case .answerOn:
                    Text("Answers will be shown")
                case .answerOff:
                    Text("Answers will not be shown")
                }
            }
            .lineLimit(1)
            .multilineTextAlignment(.center)
            .font(.system(size: 18, weight: .semibold))
            .frame(width: 250)
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
            Spacer()
            HStack {
                Group {
                    if viewModel.game.showScore {
                        Button {
                            viewModel.rulesSystem = .scoreOn
                        } label: {
                            Image(systemName: "bolt")
                                .font(.system(size: 44, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    gameManager.mainColorSheme(color: .green)
                                )
                        }
                    } else {
                        Button {
                            viewModel.rulesSystem = .scoreOff
                        } label: {
                            Image(systemName: "bolt.slash")
                                .font(.system(size: 44, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    gameManager.mainColorSheme(color: .red)
                                )
                        }
                    }
                }
                Group {
                    if viewModel.game.showAnswer {
                        Button {
                            viewModel.rulesSystem = .answerOn
                        } label: {
                            Image(systemName: "eye")
                                .font(.system(size: 44, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    gameManager.mainColorSheme(color: .green)
                                )
                        }
                    } else {
                        Button {
                            viewModel.rulesSystem = .answerOff
                        } label: {
                            Image(systemName: "eye.slash")
                                .font(.system(size: 44, weight: .regular))
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
            .padding()
            TextField("Player", text: $viewModel.player)
                .multilineTextAlignment(.center)
                .font(.system(size: 16, weight: .semibold))
                .frame(width: 250)
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
            Button {
                viewModel.stageSystem = .game
            } label: {
                Image(systemName: "checkmark")
                    .font(.system(size: 100, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        gameManager.mainColorSheme(color: .blue)
                    )
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
            }
            .opacity(viewModel.player.isEmpty ? 0.2:1.0)
            .disabled(viewModel.player.isEmpty)
        }
    }
}

struct StartStageView_Previews: PreviewProvider {
    static var previews: some View {
        StartStageView(viewModel: GameViewModel(game: GameCD()))
    }
}