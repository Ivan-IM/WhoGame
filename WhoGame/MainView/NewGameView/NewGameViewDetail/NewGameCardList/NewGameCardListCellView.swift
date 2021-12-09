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
    private let width = UIScreen.main.bounds.size.width
    
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
            .frame(width: width*0.9, height: 160)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
        }
        .frame(width: width*0.9, height: 160)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(gameManager.mainColor, lineWidth: 5)
                .frame(width: width*0.9-6, height: 154)
        )
    }
}

struct NewGameCardListCellView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameCardListCellView(gameCrad: GameCardCD())
            .environmentObject(GameManager())
    }
}
