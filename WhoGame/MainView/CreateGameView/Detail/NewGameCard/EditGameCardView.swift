//
//  EditGameCardView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.01.2022.
//

import SwiftUI

struct EditGameCardView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @ObservedObject var viewModel: NewGameCardViewModel
    @State private var showingDaleteAlert: Bool = false
    @FocusState private var showingKeyboard: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Group {
                switch viewModel.gameType {
                case 3:
                    Text("Mark your dish:")
                        .font(.system(size: 16, weight: .ultraLight))
                default:
                    Text("Question:")
                        .font(.system(size: 16, weight: .ultraLight))
                }
            }
            TextField(viewModel.question, text: $viewModel.question)
                .focused($showingKeyboard)
                .font(.system(size: 16, weight: .semibold))
            Group {
                switch viewModel.gameType {
                case 3:
                    Text("Dish:")
                        .font(.system(size: 16, weight: .ultraLight))
                default:
                    Text("Answer:")
                        .font(.system(size: 16, weight: .ultraLight))
                }
            }
            TextField(viewModel.answer, text: $viewModel.answer)
                .focused($showingKeyboard)
                .font(.system(size: 16, weight: .semibold))
            Group {
                if viewModel.gameType == 1 || viewModel.gameType == 2 {
                    Text("Fake answers:")
                        .font(.system(size: 16, weight: .ultraLight))
                    HStack {
                        Text("1.")
                        TextField(viewModel.fakeAnswerSecond, text: $viewModel.fakeAnswerSecond)
                            .focused($showingKeyboard)
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.secondary)
                    if viewModel.gameType == 2 {
                        HStack {
                            Text("2.")
                            TextField(viewModel.fakeAnswerThird, text: $viewModel.fakeAnswerThird)
                                .focused($showingKeyboard)
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.secondary)
                        HStack {
                            Text("3.")
                            TextField(viewModel.fakeAnswerFourth, text: $viewModel.fakeAnswerFourth)
                                .focused($showingKeyboard)
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.secondary)
                    }
                }
            }
            if viewModel.showHelp {
                Text("Help:")
                    .font(.system(size: 16, weight: .ultraLight))
                TextField(viewModel.help, text: $viewModel.help)
                    .focused($showingKeyboard)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.secondary)
            }
            if viewModel.showScore {
                HStack {
                    Spacer()
                    Text("Score")
                        .font(.system(size: 16, weight: .semibold))
                    Picker("Score", selection: $viewModel.score) {
                        ForEach(viewModel.scoreArray, id: \.self) {
                            Image(systemName: "\($0)")
                                .font(.system(size: 18, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    gameManager.mainColorSheme(color: .blue)
                                )
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            HStack {
                Spacer()
                Button {
                    showingKeyboard = false
                    showingDaleteAlert = true
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
                    showingKeyboard = false
                    withAnimation {
                        viewModel.showingEditCard.wrappedValue = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 44, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            gameManager.mainColorSheme(color: .blue)
                        )
                }
                Button {
                    viewModel.updateGameCard()
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
                .opacity(viewModel.isValidForm() ? 0.2:1.0)
                .disabled(viewModel.isValidForm())
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
        .alert("Delete game card?", isPresented: $showingDaleteAlert) {
            Button("OK", role: .destructive) {
                viewModel.deleteGameCard()
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}
