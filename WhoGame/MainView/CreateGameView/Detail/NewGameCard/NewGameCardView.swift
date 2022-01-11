//
//  NewGameCardView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.01.2022.
//

import SwiftUI

struct NewGameCardView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @ObservedObject var viewModel: NewGameCardViewModel
    @FocusState private var showingKeyboard: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            TextField("Question", text: $viewModel.question)
                .focused($showingKeyboard)
                .font(.system(size: 16, weight: .semibold))
            RoundedRectangle(cornerRadius: 16)
                .fill(viewModel.question.isEmpty ? gameManager.mainColorSheme(color: .red):gameManager.mainColorSheme(color: .green))
                .frame(height: 2)
            TextField("Answer", text: $viewModel.answer)
                .focused($showingKeyboard)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.secondary)
            RoundedRectangle(cornerRadius: 16)
                .fill(viewModel.answer.isEmpty ? gameManager.mainColorSheme(color: .red):gameManager.mainColorSheme(color: .green))
                .frame(height: 2)
            if viewModel.showHelp {
                TextField("Help", text: $viewModel.help)
                    .focused($showingKeyboard)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.secondary)
                RoundedRectangle(cornerRadius: 16)
                    .fill(viewModel.help.isEmpty ? gameManager.mainColorSheme(color: .red):gameManager.mainColorSheme(color: .green))
                    .frame(height: 2)
            }
            if viewModel.showScore {
                HStack {
                    Spacer()
                    Text("Score")
                        .font(.system(size: 16, weight: .semibold))
                    Picker("Score", selection: $viewModel.score) {
                        ForEach(viewModel.scoreArray, id: \.self) {
                            Image(systemName: "\($0).circle")
                                .font(.system(size: 16, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    gameManager.mainColorSheme(color: .green)
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
                    viewModel.showingNewCard.wrappedValue = false
                } label: {
                    Image(systemName: "xmark")
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
                    viewModel.saveNewGameCard()
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
                .opacity(viewModel.isValidForm() ? 0.2:1.0)
            .disabled(viewModel.isValidForm())
            }

        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
    }
}

struct NewGameCardView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            NewGameCardView(viewModel: NewGameCardViewModel(showingNewCard: .constant(true), gameId: "", showScore: true, showHelp: true))
        }
    }
}
