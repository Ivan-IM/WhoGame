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
    @Environment(\.editMode) var mode
    
    var body: some View {
        Section {
            if self.mode?.wrappedValue.isEditing ?? true {
                TextEditor(text: $viewModel.name)
                    .focused($showingKeyboard)
            } else {
                TextField("Name", text: $viewModel.name)
                    .focused($showingKeyboard)
            }
            TextField("Theme", text: $viewModel.theme)
                .focused($showingKeyboard)
            HStack {
                Text("Date")
                Spacer()
                Text("\(viewModel.date.longDate)")
            }
            Toggle("Showing question score", isOn: $viewModel.showScore)
            Toggle("Showing answers", isOn: $viewModel.showAnswer)
            Group {
                if self.mode?.wrappedValue.isEditing ?? true {
                    Button {
                        viewModel.updateGame()
                        showingKeyboard = false
                    } label: {
                        Text("Update")
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .disabled(viewModel.isValidForm())
                } else {
                    Button {
                        viewModel.saveNewGame()
                        showingKeyboard = false
                    } label: {
                        Text("Save")
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
