//
//  SaveGameView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.01.2022.
//

import SwiftUI

struct SaveGameView: View {
    
    @ObservedObject var viewModel: CreateGameViewModel
    
    var body: some View {
        Section {
            Text(viewModel.name)
            if !viewModel.theme.isEmpty {
                Text(viewModel.theme)
            }
            HStack {
                Text("Date")
                Spacer()
                Text("\(viewModel.date.longDate)")
            }
            HStack {
                Text("Showing question score")
                Spacer()
                Image(systemName: viewModel.showScore ? "checkmark.circle":"multiply.circle")
                    .foregroundColor(viewModel.showScore ? .green:.red)
            }
            HStack {
                Text("Showing answers")
                Spacer()
                Image(systemName: viewModel.showAnswer ? "checkmark.circle":"multiply.circle")
                    .foregroundColor(viewModel.showAnswer ? .green:.red)
            }
        }
        .font(.headline)
    }
}

struct SaveGameView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            SaveGameView(viewModel: CreateGameViewModel())
        }
    }
}
