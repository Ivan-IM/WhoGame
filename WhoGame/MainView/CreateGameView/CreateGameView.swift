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
                    if viewModel.saveGame {
                        SaveGameView(viewModel: viewModel)
                    } else {
                        NewGameView(viewModel: viewModel)
                    }
                }
                if viewModel.showingNewCard && !viewModel.id.isEmpty {
                    NewGameCardView(viewModel: NewGameCardViewModel(showingNewCard: $viewModel.showingNewCard, gameId: viewModel.id, showScore: viewModel.showScore))
                }
                if !viewModel.id.isEmpty {
                    GameCardListIView(gameId: viewModel.id)
                }
                
            }
            Button {
                if viewModel.id.isEmpty {
                    viewModel.saveNewGame()
                } else {
                    if !viewModel.showingNewCard {
                        viewModel.showingNewCard = true
                    }
                }
            } label: {
                if viewModel.id.isEmpty {
                    Text("Save the game")
                        .font(.title2.bold())
                } else {
                    if !viewModel.showingNewCard {
                        Text("Add question")
                            .font(.title2.bold())
                    }
                }
                
            }
            .disabled(viewModel.isValidForm())
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
