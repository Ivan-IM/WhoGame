//
//  NewGameCardView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.01.2022.
//

import SwiftUI

struct NewGameCardView: View {
    
    @ObservedObject var viewModel: NewGameCardViewModel
    
    var body: some View {
        Section {
            TextField("Question", text: $viewModel.question)
            TextField("Answer", text: $viewModel.answer)
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
        }
        .font(.headline)
    }
}

struct NewGameCardView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            NewGameCardView(viewModel: NewGameCardViewModel(showingNewCard: .constant(true), gameId: "", showScore: true))
        }
    }
}
