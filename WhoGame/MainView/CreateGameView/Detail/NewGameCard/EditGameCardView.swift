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
    @Environment(\.presentationMode) var presentationMode
    @FocusState private var showingKeyboard: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Question:")
                .font(.system(size: 16, weight: .ultraLight))
            TextEditor(text: $viewModel.question)
                .focused($showingKeyboard)
                .font(.system(size: 16, weight: .semibold))
                .frame(height: 128)
            Text("Answer:")
                .font(.system(size: 16, weight: .ultraLight))
            TextEditor(text: $viewModel.answer)
                .focused($showingKeyboard)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.secondary)
                .frame(height: 32)
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
                    viewModel.showingDaleteAlert = true
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
                    presentationMode.wrappedValue.dismiss()
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
                    presentationMode.wrappedValue.dismiss()
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
        .navigationBarHidden(true)
        .alert("Delete game card?", isPresented: $viewModel.showingDaleteAlert) {
            Button("OK", role: .destructive) {
                viewModel.deleteGameCard()
                presentationMode.wrappedValue.dismiss()
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}
