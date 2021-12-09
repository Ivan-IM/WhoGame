//
//  NewGameTitleView.swift
//  WhoGame
//
//  Created by Иван Маришин on 09.12.2021.
//

import SwiftUI

struct NewGameTitleView: View {
    
    @ObservedObject var viewModel: NewGameViewModel
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                if viewModel.gameType == 1 { Spacer() }
                RoundedRectangle(cornerRadius: 16)
                    .fill(gameManager.mainColor)
                    .frame(width: 160, height: 50)
                if viewModel.gameType == 0 { Spacer() }
            }
            .animation(.easeInOut, value: viewModel.gameType)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 16)
                        .fill(gameManager.mainColor)
                        .frame(width: 70, height: 70)
                }
            }
            VStack {
                HStack {
                    Button {
                        viewModel.gameType = 0
                    } label: {
                        Text("Who?")
                            .font(.title3)
                            .fontWeight(.heavy)
                            .foregroundColor(.primary)
                            .blendMode(viewModel.gameType == 0 ? .normal:.overlay)
                    }
                    .frame(maxWidth: .infinity)
                    Button {
                        viewModel.gameType = 1
                    } label: {
                        Text("Place")
                            .font(.title3)
                            .fontWeight(.heavy)
                            .foregroundColor(.primary)
                            .blendMode(viewModel.gameType == 1 ? .normal:.overlay)
                    }
                    .frame(maxWidth: .infinity)
                }
                Spacer()
                    if viewModel.saveGame {
                        Text(viewModel.name)
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(gameManager.mainColor)
                    } else {
                        TextField("Game name", text: $viewModel.name)
                            .font(.title2)
                            .textFieldStyle(.roundedBorder)
                }
                HStack {
                    Spacer()
                    Group {
                        if viewModel.saveGame {
                            Button {
                                viewModel.showingNewCard = true
                            } label: {
                                Image(systemName: "plus")
                                    .font(.title.bold())
                                    .foregroundColor(.primary)
                                    .blendMode(.overlay)
                            }
                        } else {
                            Button {
                                viewModel.saveNewGame()
                            } label: {
                                Image(systemName: "checkmark")
                                    .font(.title.bold())
                                    .foregroundColor(.primary)
                                    .blendMode(.overlay)
                            }
                        }
                    }
                    .frame(width: 30, height: 30)
                    .padding(.top, 8)
                }
            }
            .padding()
            .frame(width: 300, height: 160)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
        }
        .frame(width: 300, height: 160)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(gameManager.mainColor, lineWidth: 5)
                .frame(width: 295, height: 155)
        )
    }
}

struct NewGameTitleView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameTitleView(viewModel: NewGameViewModel())
            .environmentObject(GameManager())
    }
}
