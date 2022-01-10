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
            HStack {
                Text("New game")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(
                        gameManager.mainColorSheme(color: .red)
                    )
                Spacer()
                Button {
                    viewModel.clearGame()
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "multiply.circle")
                        .font(.system(size: 32, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            gameManager.mainColorSheme(color: .blue)
                        )
                }
            }
            .padding(.horizontal)
            Group {
                if !viewModel.saveGame || viewModel.editMode {
                    NewGameView(viewModel: viewModel)
                        .padding(.horizontal)
                } else {
                    SaveGameView(viewModel: viewModel)
                        .padding(.horizontal)
                }
            }
            if viewModel.showingNewCard && !viewModel.id.isEmpty {
                NewGameCardView(viewModel: NewGameCardViewModel(showingNewCard: $viewModel.showingNewCard, gameId: viewModel.id, showScore: viewModel.showScore))
                    .padding(.horizontal)
            }
            if !viewModel.id.isEmpty {
                GameCardListIView(gameId: viewModel.id, showScore: viewModel.showScore)
                    .padding(.horizontal)
            }
        }
        .navigationBarHidden(true)
        .alert("Delete game?", isPresented: $viewModel.showingDaleteAlert) {
            Button("OK", role: .destructive) {
                viewModel.deleteGame()
                presentationMode.wrappedValue.dismiss()
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}

struct CreateGameView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGameView(viewModel: CreateGameViewModel())
            .environmentObject(GameManager())
    }
}
