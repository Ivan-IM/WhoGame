//
//  EditGameCardView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.01.2022.
//

import SwiftUI

struct EditGameCardView: View {
    
    @ObservedObject var viewModel: NewGameCardViewModel
    @Environment(\.presentationMode) var presentationMode
    @FocusState private var showingKeyboard: Bool
    
    var body: some View {
        Form {
            Section {
                Text("Question:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                TextEditor(text: $viewModel.question)
                    .focused($showingKeyboard)
                Text("Answer:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                TextEditor(text: $viewModel.answer)
                    .focused($showingKeyboard)
                if viewModel.showScore {
                    HStack {
                        Text("Score")
                        Spacer()
                        Picker("Score", selection: $viewModel.score) {
                            ForEach(viewModel.scoreArray, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }
                Button {
                    viewModel.updateGameCard()
                    showingKeyboard = false
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Update game card")
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .disabled(viewModel.isValidForm())

            }
            .font(.headline)
            .navigationTitle("Game card editing")
        }
    }
}
