//
//  NewGameCardListCellView.swift
//  WhoGame
//
//  Created by Иван Маришин on 09.12.2021.
//

import SwiftUI

struct NewGameCardListCellView: View {
    
    @EnvironmentObject var gameManager: GameManager
    var gameCrad: GameCardCD
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                HStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(gameManager.mainColor)
                        .frame(width: 70, height: 70)
                    Spacer()
                    RoundedRectangle(cornerRadius: 16)
                        .fill(gameManager.mainColor)
                        .frame(width: 70, height: 70)
                }
                Spacer()
            }
            VStack {
                HStack {
                    Image(systemName: "\(gameCrad.mark).circle")
                        .font(.title.bold())
                        .foregroundColor(.primary)
                        .blendMode(.overlay)
                    Spacer()
                    Button {
                        PersistenceController.shared.delete(gameCrad)
                    } label: {
                        Image(systemName: "multiply")
                            .font(.title.bold())
                            .foregroundColor(.primary)
                            .blendMode(.overlay)
                    }
                }
                Spacer()
                Text(gameCrad.question ?? "Unknown")
                Text(gameCrad.answer ?? "Unknown")
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

struct NewGameCardListCellView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameCardListCellView(gameCrad: GameCardCD())
            .environmentObject(GameManager())
    }
}
