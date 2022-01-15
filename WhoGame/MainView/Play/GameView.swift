//
//  GameView.swift
//  WhoGame
//
//  Created by Иван Маришин on 09.01.2022.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Text("\(viewModel.game.name ?? "Unknown")")
                    .lineLimit(1)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(
                        gameManager.mainColorSheme(color: .red)
                    )
                Spacer()
                if viewModel.game.showHelp && viewModel.stageSystem == .game {
                    Button {
                        viewModel.showingHelpAlert = true
                    } label: {
                        Image(systemName: "bell")
                            .font(.system(size: 32, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .green)
                            )
                    }
                }
                Button {
                    viewModel.showingExitAlert = true
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
                switch viewModel.stageSystem {
                case .start:
                    switch viewModel.game.type {
                    default:
                        StartStageView(viewModel: viewModel)
                    }
                case .game:
                    switch viewModel.game.type {
                    case 1, 2:
                        GameStageTestView(viewModel: viewModel)
                    default:
                        GameStageView(viewModel: viewModel)
                    }
                case .end:
                    switch viewModel.game.type {
                    default:
                        EndStageView(viewModel: viewModel)
                    }
                }
            }
        }
        .padding()
        .navigationBarHidden(true)
        .alert("Quit the game?", isPresented: $viewModel.showingExitAlert) {
            Button("OK", role: .destructive) {
                viewModel.clearGame()
                presentationMode.wrappedValue.dismiss()
            }
            Button("Cancel", role: .cancel) {}
        }
        .alert("Help", isPresented: $viewModel.showingHelpAlert, actions: {
            
        }, message: {
            Text("\(viewModel.gameCards[viewModel.index].help ?? "")")
        })
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(game: GameCD()))
    }
}
