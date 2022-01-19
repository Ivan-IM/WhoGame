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
        ZStack(alignment: .top) {
            BackgroundView()
            VStack {
                HStack {
                    Text("New game")
                        .lineLimit(1)
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
                Group {
                    if !viewModel.saveGame || viewModel.editMode {
                        NewGameView(viewModel: viewModel)
                    } else {
                        SaveGameView(viewModel: viewModel)
                    }
                }
                if viewModel.id.isEmpty {
                    Spacer()
                    TypeGameView(viewModel: viewModel)
                        .transition(.move(edge: .leading))
                        .animation(.default, value: viewModel.id)
                    Spacer()
                }
                if viewModel.showingNewCard && !viewModel.id.isEmpty {
                    Group {
                        switch viewModel.type {
                        case 1, 2:
                            NewGameCardTestView(viewModel: NewGameCardViewModel(showingNewCard: $viewModel.showingNewCard, gameType: viewModel.type, gameId: viewModel.id, showScore: viewModel.showScore, showHelp: viewModel.showHelp))
                        case 3:
                            NewGameCardTastyView(viewModel: NewGameCardViewModel(showingNewCard: $viewModel.showingNewCard, gameType: viewModel.type, gameId: viewModel.id, showScore: viewModel.showScore, showHelp: viewModel.showHelp))
                        default:
                            NewGameCardView(viewModel: NewGameCardViewModel(showingNewCard: $viewModel.showingNewCard, gameType: viewModel.type, gameId: viewModel.id, showScore: viewModel.showScore, showHelp: viewModel.showHelp))
                        }
                    }
                    .transition(.move(edge: .leading))
                    .animation(.default, value: viewModel.showingNewCard)
                }
                if !viewModel.id.isEmpty {
                    GameCardListIView(gameId: viewModel.id, gameType: viewModel.type, editMode: viewModel.listEditMode, showScore: viewModel.showScore, showHelp: viewModel.showHelp)
                }
            }
            .padding()
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
}

struct CreateGameView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGameView(viewModel: CreateGameViewModel())
            .environmentObject(GameManager())
    }
}
