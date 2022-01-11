//
//  EndStageView.swift
//  WhoGame
//
//  Created by Иван Маришин on 11.01.2022.
//

import SwiftUI

struct EndStageView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Spacer()
            if viewModel.game.showScore {
                Text("Scores: \(viewModel.score)")
                    .lineLimit(1)
                    .font(.system(size: 33, weight: .semibold))
                    .foregroundStyle(
                        gameManager.mainColorSheme(color: .blue)
                    )
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
            } else {
                Text("Right answers: \(viewModel.rightAnswers)")
                    .lineLimit(1)
                    .font(.system(size: 33, weight: .semibold))
                    .foregroundStyle(
                        gameManager.mainColorSheme(color: .blue)
                    )
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
            }
            Spacer()
            Button {
                viewModel.clearGame()
            } label: {
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 100, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        gameManager.mainColorSheme(color: .green)
                    )
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
            }
        }
    }
}

struct EndStageView_Previews: PreviewProvider {
    static var previews: some View {
        EndStageView(viewModel: GameViewModel(game: GameCD()))
    }
}
