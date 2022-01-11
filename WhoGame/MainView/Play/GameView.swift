//
//  GameView.swift
//  WhoGame
//
//  Created by Иван Маришин on 09.01.2022.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Text("\(viewModel.game.name ?? "Unknown")")
                    .lineLimit(1)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(
                        gameManager.mainColorSheme(color: .red)
                    )
                Spacer()
                Button {
                    viewModel.clearGame()
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "multiply.circle")
                        .font(.system(size: 32, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            gameManager.mainColorSheme(color: .blue)
                        )
                }
            }
            Group {
                if viewModel.endGame {
                    VStack {
                        Spacer()
                        if viewModel.game.showScore {
                            Text("Score: \(viewModel.score)")
                                .lineLimit(1)
                                .font(.system(size: 33, weight: .semibold))
                                .foregroundStyle(
                                    gameManager.mainColorSheme(color: .blue)
                                )
                                .padding()
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                        } else {
                            Text("Right answers: \(viewModel.score)")
                                .lineLimit(1)
                                .font(.system(size: 33, weight: .semibold))
                                .foregroundStyle(
                                    gameManager.mainColorSheme(color: .blue)
                                )
                                .padding()
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                        }
                        Spacer()
                        Button {
                            viewModel.clearGame()
                        } label: {
                            Image(systemName: "arrow.clockwise")
                                .font(.system(size: 100, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    gameManager.mainColorSheme(color: .green)
                                )
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                        }
                    }
                } else {
                    VStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 3) {
                                Text("Progress: \(viewModel.index+1)/\(viewModel.gameCards.count)")
                                    .lineLimit(1)
                                if viewModel.game.showScore {
                                    Text("Score: \(viewModel.score)")
                                        .lineLimit(1)
                                } else {
                                    Text("Right answers: \(viewModel.score)")
                                        .lineLimit(1)
                                }
                            }
                            Spacer()
                        }
                        .font(.system(size: 16, weight: .semibold))
                        Spacer()
                        Text("\(viewModel.gameCards[viewModel.index].question ?? "Unknown")")
                            .font(.system(size: 18, weight: .regular))
                            .padding()
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                        Spacer()
                        switch viewModel.answerSystem {
                        case .text:
                            TextField("Answer", text: $viewModel.answer)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 16, weight: .semibold))
                                .frame(width: 250)
                                .padding()
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                        case .right:
                            if viewModel.game.showAnswer {
                                Text("Answer: \(viewModel.gameCards[viewModel.index].answer ?? "Unknown")")
                                    .foregroundColor(.green)
                                    .font(.system(size: 16, weight: .semibold))
                                    .frame(width: 250)
                                    .padding()
                                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                            } else {
                                Text("Right answer")
                                    .foregroundColor(.green)
                                    .font(.system(size: 16, weight: .semibold))
                                    .frame(width: 250)
                                    .padding()
                                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                            }
                        case .wrong:
                            if viewModel.game.showAnswer {
                                Text("Answer: \(viewModel.gameCards[viewModel.index].answer ?? "Unknown")")
                                    .foregroundColor(.red)
                                    .font(.system(size: 16, weight: .semibold))
                                    .frame(width: 250)
                                    .padding()
                                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                            } else {
                                Text("Wrong answer")
                                    .foregroundColor(.red)
                                    .font(.system(size: 16, weight: .semibold))
                                    .frame(width: 250)
                                    .padding()
                                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                            }
                        }
                        Button {
                            if viewModel.answerSystem == .text {
                                viewModel.answerSystem = viewModel.checkAnswer()
                            } else {
                                viewModel.nextCard()
                            }
                        } label: {
                            if viewModel.answerSystem == .text {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 100, weight: .regular))
                                    .symbolVariant(.circle.fill)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(
                                        Color.white.opacity(0.8),
                                        gameManager.mainColorSheme(color: .blue)
                                    )
                                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                            } else {
                                Group {
                                    if viewModel.answerSystem == .right {
                                        Image(systemName: "arrow.right")
                                            .font(.system(size: 100, weight: .regular))
                                            .symbolVariant(.circle.fill)
                                            .symbolRenderingMode(.palette)
                                            .foregroundStyle(
                                                Color.white.opacity(0.8),
                                                gameManager.mainColorSheme(color: .green)
                                            )
                                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                                    } else {
                                        Image(systemName: "arrow.right")
                                            .font(.system(size: 100, weight: .regular))
                                            .symbolVariant(.circle.fill)
                                            .symbolRenderingMode(.palette)
                                            .foregroundStyle(
                                                Color.white.opacity(0.8),
                                                gameManager.mainColorSheme(color: .red)
                                            )
                                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                                    }
                                }
                            }
                        }
                        .opacity(viewModel.answer.isEmpty ? 0.2:1.0)
                        .disabled(viewModel.answer.isEmpty)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .padding()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(game: GameCD()))
    }
}
