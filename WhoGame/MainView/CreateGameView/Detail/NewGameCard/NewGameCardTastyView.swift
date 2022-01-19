//
//  NewGameCardTastyView.swift
//  WhoGame
//
//  Created by Иван Маришин on 15.01.2022.
//

import SwiftUI

struct NewGameCardTastyView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @ObservedObject var viewModel: NewGameCardViewModel
    @FocusState private var showingKeyboard: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            TextField("Mark your dish", text: $viewModel.question)
                .focused($showingKeyboard)
                .font(.system(size: 16, weight: .semibold))
            RoundedRectangle(cornerRadius: 16)
                .fill(viewModel.question.isEmpty ? gameManager.mainColorSheme(color: .red):gameManager.mainColorSheme(color: .green))
                .frame(height: 2)
            TextField("Dish", text: $viewModel.answer)
                .focused($showingKeyboard)
                .font(.system(size: 16, weight: .semibold))
            RoundedRectangle(cornerRadius: 16)
                .fill(viewModel.answer.isEmpty ? gameManager.mainColorSheme(color: .red):gameManager.mainColorSheme(color: .green))
                .frame(height: 2)
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
                .opacity(viewModel.isValidForm() ? 0.2:1.0)
            .disabled(viewModel.isValidForm())
            }

        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
    }
}
