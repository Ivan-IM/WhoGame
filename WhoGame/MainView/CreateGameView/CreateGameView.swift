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
            Form {
                Group {
                    if !viewModel.saveGame || viewModel.editMode {
                        NewGameView(viewModel: viewModel)
                    } else {
                        SaveGameView(viewModel: viewModel)
                    }
                }
                if viewModel.showingNewCard && !viewModel.id.isEmpty {
                    NewGameCardView(viewModel: NewGameCardViewModel(showingNewCard: $viewModel.showingNewCard, gameId: viewModel.id, showScore: viewModel.showScore))
                }
                if !viewModel.id.isEmpty {
                    Section("Game card list") {
                        GameCardListIView(gameId: viewModel.id, showScore: viewModel.showScore)
                    }
                }
                
            }
            Button {
                if !viewModel.showingNewCard {
                    viewModel.showingNewCard = true
                }
                
            } label: {
                if !viewModel.showingNewCard && viewModel.saveGame {
                    Text("Add new game card")
                        .font(.title2.bold())
                }
            }
            .padding()
        }
        .navigationBarHidden(false)
        .navigationTitle("New game")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }
}

struct CreateGameView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGameView(viewModel: CreateGameViewModel())
    }
}
