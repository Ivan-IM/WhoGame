//
//  NewGameCardTestView.swift
//  WhoGame
//
//  Created by Иван Маришин on 13.01.2022.
//

import SwiftUI

struct NewGameCardTestView: View {
    
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
            HStack {
                TextField("Answer", text: $viewModel.answer)
                    .focused($showingKeyboard)
                Image(systemName: "checkmark")
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        gameManager.mainColorSheme(color: .green)
                    )
                    .opacity(0.6)
                
            }
            .font(.system(size: 16, weight: .semibold))
            RoundedRectangle(cornerRadius: 16)
                .fill(viewModel.answer.isEmpty ? gameManager.mainColorSheme(color: .red):gameManager.mainColorSheme(color: .green))
                .frame(height: 2)
            HStack {
                TextField("Fake answer", text: $viewModel.fakeAnswerSecond)
                    .focused($showingKeyboard)
                Image(systemName: "xmark")
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        gameManager.mainColorSheme(color: .red)
                    )
                    .opacity(0.6)
                
            }
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(.secondary)
            RoundedRectangle(cornerRadius: 16)
                .fill(viewModel.fakeAnswerSecond.isEmpty ? gameManager.mainColorSheme(color: .red):gameManager.mainColorSheme(color: .green))
                .frame(height: 2)
            if viewModel.gameType == 2 {
                HStack {
                    TextField("Fake answer", text: $viewModel.fakeAnswerThird)
                        .focused($showingKeyboard)
                    Image(systemName: "xmark")
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            gameManager.mainColorSheme(color: .red)
                        )
                        .opacity(0.6)
                    
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.secondary)
                RoundedRectangle(cornerRadius: 16)
                    .fill(viewModel.fakeAnswerThird.isEmpty ? gameManager.mainColorSheme(color: .red):gameManager.mainColorSheme(color: .green))
                    .frame(height: 2)
                HStack {
                    TextField("Fake answer", text: $viewModel.fakeAnswerFourth)
                        .focused($showingKeyboard)
                    Image(systemName: "xmark")
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            gameManager.mainColorSheme(color: .red)
                        )
                        .opacity(0.6)
                    
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.secondary)
                RoundedRectangle(cornerRadius: 16)
                    .fill(viewModel.fakeAnswerFourth.isEmpty ? gameManager.mainColorSheme(color: .red):gameManager.mainColorSheme(color: .green))
                    .frame(height: 2)
            }
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
                    withAnimation {
                        viewModel.showingNewCard.wrappedValue = false
                    }
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
                    withAnimation {
                        viewModel.saveNewGameCard()
                    }
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
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
    }
}
