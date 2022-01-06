//
//  CreateGameView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.01.2022.
//

import SwiftUI

struct CreateGameView: View {
    
    @ObservedObject var viewModel: CreateGameViewModel
    
    var body: some View {
        VStack {
            Text("New game")
                .font(.title2.bold())
                .foregroundColor(.primary)
            Form {
                Group {
                    if viewModel.saveGame {
                        SaveGameView(viewModel: viewModel)
                    } else {
                        NewGameView(viewModel: viewModel)
                    }
                }

            }
            Button {
                
            } label: {
                Text("Save the game")
                    .font(.title2.bold())
            }
            .disabled(viewModel.isValidForm())
        }
        .navigationBarHidden(true)
    }
}

struct CreateGameView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGameView(viewModel: CreateGameViewModel())
    }
}
