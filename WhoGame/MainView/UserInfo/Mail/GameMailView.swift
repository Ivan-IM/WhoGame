//
//  GameMailView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.02.2022.
//

import SwiftUI

struct GameMailView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @EnvironmentObject var fbManager: FBManager
    @ObservedObject var viewModel: GameMailViewModel = GameMailViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Mail")
                        .lineLimit(1)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(
                            gameManager.mainColorSheme(color: .green)
                        )
                    Spacer()
                    Button {
                        withAnimation {
                            gameManager.showingMailView = false
                        }
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
                ScrollView(showsIndicators: false) {
                    ForEach(fbManager.games.sorted{ $0.date < $1.date }) { game in
                        GameMailCellView(viewModel: viewModel, game: game)
                    }
                    .padding(.bottom, 32)
                }
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(
            RoundedRectangle(cornerRadius: 34)
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        )
    }
}

struct GameMailView_Previews: PreviewProvider {
    static var previews: some View {
        GameMailView()
    }
}
