//
//  GameHystoryCellView.swift
//  WhoGame
//
//  Created by Иван Маришин on 11.01.2022.
//

import SwiftUI

struct GameHistoryCellView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @State var showingDaleteAlert = false
    var story: GameHistoryCD
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text("\(story.gameName ?? "Unknown")")
                    .lineLimit(1)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(
                        gameManager.mainColorSheme(color: .green)
                    )
                Text("Player: \(story.player ?? "Unknown")")
                    .lineLimit(1)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                Text("Right answers: \(story.rightAnswers)")
                    .lineLimit(1)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                if story.showScore {
                    Text("Scores: \(story.score)")
                        .lineLimit(1)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                }
                Text("Date of creation: \(story.date?.longDate ?? "Unknown")")
                    .lineLimit(1)
                    .font(.system(size: 16, weight: .ultraLight))
            }
            Spacer()
            VStack(alignment: .trailing) {
                Button {
                    showingDaleteAlert = true
                } label: {
                    Image(systemName: "trash")
                        .font(.system(size: 44, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            gameManager.mainColorSheme(color: .red)
                        )
                }
                Spacer()
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
        .alert("Delete history?", isPresented: $showingDaleteAlert) {
            Button("OK", role: .destructive) {
                PersistenceController.shared.delete(story)
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}