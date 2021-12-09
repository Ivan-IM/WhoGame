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
                    .frame(width: 150, height: 50)
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
                            .font(.title3.bold())
                            .foregroundColor(.primary)
                            .blendMode(viewModel.gameType == 0 ? .normal:.overlay)
                    }
                    .frame(maxWidth: .infinity)
                    Button {
                        viewModel.gameType = 1
                    } label: {
                        Text("Place")
                            .font(.title3.bold())
                            .foregroundColor(.primary)
                            .blendMode(viewModel.gameType == 1 ? .normal:.overlay)
                    }
                    .frame(maxWidth: .infinity)
                }
                Spacer()
                TextField("Game name", text: $viewModel.name)
                    .textFieldStyle(.roundedBorder)
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.title.bold())
                            .foregroundColor(.primary)
                            .blendMode(.overlay)
                    }
                    .padding(.top, 8)

                }
            }
            .padding()
            .frame(width: 280, height: 160)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
        }
        .frame(width: 280, height: 120)
    }
}

struct NewGameTitleView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameTitleView(viewModel: NewGameViewModel())
            .environmentObject(GameManager())
    }
}
