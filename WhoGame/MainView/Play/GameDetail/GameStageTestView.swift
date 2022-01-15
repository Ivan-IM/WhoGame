//
//  GameStageTestView.swift
//  WhoGame
//
//  Created by Иван Маришин on 13.01.2022.
//

import SwiftUI

struct GameStageTestView: View {
    
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
            Group {
                switch viewModel.answerSystem {
                case .text:
                    VStack {
                        ForEach(viewModel.answers, id: \.self) { answer in
                            Button {
                                viewModel.answer = answer
                            } label: {
                                HStack {
                                    Text("\(answer)")
                                        .lineLimit(1)
                                    Spacer()
                                    Image(systemName: "checkmark")
                                        .symbolVariant(viewModel.answer == answer ? .circle.fill:.circle)
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(
                                            Color.white.opacity(viewModel.answer == answer ? 0.8:0.0),
                                            gameManager.mainColorSheme(color: viewModel.answer == answer ? .green:.blue)
                                        )
                                }
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.primary)
                                .frame(width: gameManager.width*0.77)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                            }
                            
                        }
                    }
                case .right:
                    VStack {
                        ForEach(viewModel.answers, id: \.self) { answer in
                            HStack {
                                Text("\(answer)")
                                    .lineLimit(1)
                                Spacer()
                                Image(systemName: "checkmark")
                                    .symbolVariant(viewModel.answer == answer ? .circle.fill:.circle)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(
                                        Color.white.opacity(viewModel.answer == answer ? 0.8:0.0),
                                        gameManager.mainColorSheme(color: viewModel.answer == answer ? .green:.blue)
                                    )
                            }
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.primary)
                            .frame(width: gameManager.width*0.77)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                        }
                    }
                case .wrong:
                    if viewModel.game.showAnswer {
                        VStack {
                            ForEach(viewModel.answers, id: \.self) { answer in
                                HStack {
                                    Text("\(answer)")
                                        .lineLimit(1)
                                    Spacer()
                                    if answer == viewModel.gameCards[viewModel.index].answer {
                                        Image(systemName: "checkmark")
                                            .symbolVariant(.circle.fill)
                                            .symbolRenderingMode(.palette)
                                            .foregroundStyle(
                                                Color.white.opacity(0.8),
                                                gameManager.mainColorSheme(color: .green)
                                            )
                                    } else {
                                        Image(systemName: "xmark")
                                            .symbolVariant(viewModel.answer == answer ? .circle.fill:.circle)
                                            .symbolRenderingMode(.palette)
                                            .foregroundStyle(
                                                Color.white.opacity(viewModel.answer == answer ? 0.8:0.0),
                                                gameManager.mainColorSheme(color: viewModel.answer == answer ? .red:.blue)
                                            )
                                    }
                                }
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.primary)
                                .frame(width: gameManager.width*0.77)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                            }
                        }
                    } else {
                        VStack {
                            ForEach(viewModel.answers, id: \.self) { answer in
                                HStack {
                                    Text("\(answer)")
                                        .lineLimit(1)
                                    Spacer()
                                    Image(systemName: "xmark")
                                        .symbolVariant(viewModel.answer == answer ? .circle.fill:.circle)
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(
                                            Color.white.opacity(viewModel.answer == answer ? 0.8:0.0),
                                            gameManager.mainColorSheme(color: viewModel.answer == answer ? .red:.blue)
                                        )
                                }
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.primary)
                                .frame(width: gameManager.width*0.77)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                            }
                        }
                    }
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
                        .font(.system(size: 88, weight: .regular))
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
                                .font(.system(size: 88, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    gameManager.mainColorSheme(color: .green)
                                )
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                        } else {
                            Image(systemName: "arrow.right")
                                .font(.system(size: 88, weight: .regular))
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
