//
//  NewGameView.swift
//  WhoGame
//
//  Created by Иван Маришин on 09.12.2021.
//

import SwiftUI

struct NewGameView2: View {
    
    @ObservedObject var viewModel: NewGameViewModel
    @EnvironmentObject var gameManager: GameManager
    
    private let width = UIScreen.main.bounds.size.width
    
    var body: some View {
        VStack(spacing: 16) {
            NewGameTitleView(viewModel: viewModel, width: width)
            if viewModel.showingNewCard {
//                NewGameCardView2(viewModel: NewGameCardViewModel(showingNewCard: $viewModel.showingNewCard, gameId: viewModel.gameId), width: width)
//                    .transition(.offset(x: -width))
            }
            if viewModel.saveGame {
                NewGameCardListView(gameId: viewModel.gameId)
            }
        }
        .animation(.spring(response: 0.6, dampingFraction: 0.6), value: viewModel.showingNewCard)
    }
}

struct NewGameView2_Previews: PreviewProvider {
    static var previews: some View {
        NewGameView2(viewModel: NewGameViewModel())
            .environmentObject(GameManager())
            .preferredColorScheme(.dark)
    }
}
