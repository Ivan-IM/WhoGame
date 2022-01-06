//
//  NewGameView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.01.2022.
//

import SwiftUI

struct NewGameView: View {
    
    @ObservedObject var viewModel: CreateGameViewModel
    
    var body: some View {
        Section {
            TextField("Name", text: $viewModel.name)
            TextField("Theme", text: $viewModel.theme)
            HStack {
                Text("Date")
                Spacer()
                Text("\(viewModel.date.longDate)")
            }
            Toggle("Showing question score", isOn: $viewModel.showScore)
            Toggle("Showing answers", isOn: $viewModel.showAnswer)
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
