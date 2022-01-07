//
//  NewGameView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.01.2022.
//

import SwiftUI

struct NewGameView: View {
    
    @ObservedObject var viewModel: CreateGameViewModel
    @FocusState private var showingKeyboard: Bool
    
    var body: some View {
        Section {
            if viewModel.editMode {
                TextEditor(text: $viewModel.name)
                    .focused($showingKeyboard)
            } else {
                TextField("Name", text: $viewModel.name)
                    .focused($showingKeyboard)
            }
            TextField("Theme", text: $viewModel.theme)
                .focused($showingKeyboard)
            HStack {
                Text("Date of creation")
                Spacer()
                Text("\(viewModel.date.longDate)")
            }
            Toggle("Showing question score", isOn: $viewModel.showScore)
            Toggle("Showing answers", isOn: $viewModel.showAnswer)
            Group {
                if viewModel.editMode {
                    Button {
                        viewModel.updateGame()
                        showingKeyboard = false
                    } label: {
                        Text("Update game")
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .disabled(viewModel.isValidForm())
                } else {
                    Button {
                        viewModel.saveNewGame()
                        showingKeyboard = false
                    } label: {
                        Text("Save game")
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .disabled(viewModel.isValidForm())
                }
                
            }
        }
        .font(.headline)
    }
}

struct NewGameView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            NewGameView(viewModel: CreateGameViewModel())
        }
    }
}