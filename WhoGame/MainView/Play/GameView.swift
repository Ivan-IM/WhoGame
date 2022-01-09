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
                    HStack(spacing: 32) {
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
                        Text("Progress: \(viewModel.index+1)/\(viewModel.gameCards.count)")
                        Spacer()
                        if viewModel.game.showScore {
                            Text("Score: \(viewModel.score)")
                        } else {
                            Text("Right answers: \(viewModel.score)")
                        }
                    }
                    .padding()
                    Spacer()
                    Text("\(viewModel.gameCards[viewModel.index].question ?? "Unknown")")
                    Spacer()
                    switch viewModel.answerSystem {
                    case .text:
                        TextField("Answer", text: $viewModel.answer)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 250)
                    case .right:
                        Text("Right answer")
                            .foregroundColor(.green)
                    case .wrong:
                        Text("Wrong answer")
                            .foregroundColor(.red)
                    }
                    Button {
                        if viewModel.answerSystem == .text {
                            viewModel.answerSystem = viewModel.checkAnswer()
                        } else {
                            viewModel.nextCard()
                        }
                    } label: {
                        if viewModel.answerSystem == .text {
                            Text("Check")
                        } else {
                            Text("Next")
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(game: GameCD()))
    }
}
