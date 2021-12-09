//
//  NewGameView.swift
//  WhoGame
//
//  Created by Иван Маришин on 09.12.2021.
//

import SwiftUI

struct NewGameView: View {
    
    @ObservedObject var viewModel: NewGameViewModel
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        VStack(spacing: 16) {
            NewGameTitleView(viewModel: viewModel)
        }
    }
}

struct NewGameView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameView(viewModel: NewGameViewModel())
            .environmentObject(GameManager())
            .preferredColorScheme(.dark)
    }
}
