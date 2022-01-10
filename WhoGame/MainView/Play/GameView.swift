//
//  GameView.swift
//  WhoGame
//
//  Created by Иван Маришин on 09.01.2022.
//

import SwiftUI

struct GameView: View {
    
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Text("\(viewModel.game.name ?? "Unknown")")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(
                        LinearGradient(colors: [Color.red, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing)
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
                            LinearGradient(colors: [Color.teal, Color.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                }
            }
            .padding(.horizontal)
            Group {
                if viewModel.endGame {
                    VStack {
                        Spacer()
                        if viewModel.game.showScore {
                            Text("Score: \(viewModel.score)")
                        } else {
                            Text("Right answers: \(viewModel.score)")
                        }
                        Spacer()
                        HStack(spacing: 64) {
                            Button {
                                viewModel.clearGame()
                            } label: {
                                Image(systemName: "arrow.clockwise")
                            }
                            Button {
                                viewModel.clearGame()
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "xmark")
                            }
                        }
                        .padding()
                    }
                } else {
                    VStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 3) {
                                Text("Progress: \(viewModel.index+1)/\(viewModel.gameCards.count)")
                            if viewModel.game.showScore {
                                Text("Score: \(viewModel.score)")
                            } else {
                                Text("Right answers: \(viewModel.score)")
                            }
                            }
                            Spacer()
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.horizontal)
                        Spacer()
                        Text("\(viewModel.gameCards[viewModel.index].question ?? "Unknown")")
                        Spacer()
                        switch viewModel.answerSystem {
                        case .text:
                            TextField("Answer", text: $viewModel.answer)
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 250)
                        case .right:
                            if viewModel.game.showAnswer {
                                Text("\(viewModel.gameCards[viewModel.index].answer ?? "Unknown")")
                                    .foregroundColor(.green)
                            } else {
                                Text("Right answer")
                                    .foregroundColor(.green)
                            }
                        case .wrong:
                            if viewModel.game.showAnswer {
                                Text("\(viewModel.gameCards[viewModel.index].answer ?? "Unknown")")
                                    .foregroundColor(.red)
                            } else {
                                Text("Wrong answer")
                                    .foregroundColor(.red)
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
                                        LinearGradient(colors: [Color.teal, Color.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                            } else {
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 100, weight: .regular))
                                    .symbolVariant(.circle.fill)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(
                                        Color.white.opacity(0.8),
                                        LinearGradient(colors: [Color.red, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                            }
                        }
                        .padding()
                        .opacity(viewModel.answer.isEmpty ? 0.2:1.0)
                        .disabled(viewModel.answer.isEmpty)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(game: GameCD()))
    }
}
