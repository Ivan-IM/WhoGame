//
//  GameHistoryView.swift
//  WhoGame
//
//  Created by Иван Маришин on 11.01.2022.
//

import SwiftUI

struct GameHistoryView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @FetchRequest(entity: GameHistoryCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GameHistoryCD.date, ascending: false)]) var hystory: FetchedResults<GameHistoryCD>
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Text("History")
                    .lineLimit(1)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(
                        gameManager.mainColorSheme(color: .green)
                    )
                Spacer()
                Button {
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
            ScrollView {
                ForEach(hystory) { story in
                    GameHistoryCellView(story: story)
                }
            }
        }
        .navigationBarHidden(true)
        .padding()
    }
}

struct GameHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        GameHistoryView()
    }
}
