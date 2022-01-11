//
//  GameStageView.swift
//  WhoGame
//
//  Created by Иван Маришин on 11.01.2022.
//

import SwiftUI

struct GameStageView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 3) {
                    Text("Progress: \(viewModel.index+1)/\(viewModel.gameCards.count)")
                        .lineLimit(1)
                    HStack {
                        Text("Right answers: \(viewModel.rightAnswers)")
                            .lineLimit(1)
                        if viewModel.answerSystem == .right {
                            Text("+ 1")
                                .lineLimit(1)
                                .foregroundColor(.green)
                        }
                        Spacer()
                    }
                    if viewModel.game.showScore {
                        HStack {
                            Text("Scores: \(viewModel.score)")
                                .lineLimit(1)
                            if viewModel.answerSystem == .right {
                                Text("+ \(viewModel.gameCards[viewModel.index].score)")
                                    .lineLimit(1)
                                    .foregroundColor(.green)
                            }
                            Spacer()
                        }
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

struct GameStageView_Previews: PreviewProvider {
    static var previews: some View {
        GameStageView(viewModel: GameViewModel(game: GameCD()))
    }
}
