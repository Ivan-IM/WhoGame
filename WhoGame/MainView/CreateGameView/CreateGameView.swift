//
//  CreateGameView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.01.2022.
//

import SwiftUI

struct CreateGameView: View {
    
    @ObservedObject var viewModel: CreateGameViewModel
    @EnvironmentObject var gameManager: GameManager
    @Environment(\.presentationMode) var presentationMode
    
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
        .navigationBarBackButtonHidden(true)
        .navigationTitle("New game")
        .alert("Clear?", isPresented: $viewModel.showingClearAlert) {
            Button("OK", role: .destructive) {
                viewModel.clearGame()
            }
            Button("Cancel", role: .cancel) {}
        }
        .alert("Delete game?", isPresented: $viewModel.showingDaleteAlert) {
            Button("OK", role: .destructive) {
                viewModel.deleteGame()
                presentationMode.wrappedValue.dismiss()
            }
            Button("Cancel", role: .cancel) {}
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                    viewModel.clearGame()
                } label: {
                    Text("Done")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                if !viewModel.id.isEmpty && !viewModel.hideClear {
                    Button {
                        viewModel.showingClearAlert = true
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                if !viewModel.id.isEmpty {
                    Button {
                        viewModel.showingDaleteAlert = true
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                if !viewModel.id.isEmpty {
                    EditButton()
                }
            }
        }
    }
}

struct CreateGameView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGameView(viewModel: CreateGameViewModel())
            .environmentObject(GameManager())
    }
}
