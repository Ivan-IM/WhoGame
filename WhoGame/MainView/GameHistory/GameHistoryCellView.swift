//
//  GameHystoryCellView.swift
//  WhoGame
//
//  Created by Иван Маришин on 11.01.2022.
//

import SwiftUI

struct GameHistoryCellView: View {
    
    @EnvironmentObject var gameManager: GameManager
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
                switch story.gameType {
                case 3:
                    Text("Positions: \(story.answersHistory?.count ?? 0)")
                        .lineLimit(1)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                default:
                    Text("Right answers: \(story.rightAnswers)/\(story.questions)")
                        .lineLimit(1)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                    if story.showScore {
                        Text("Scores: \(story.score)")
                            .lineLimit(1)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                }
                HStack {
                    Text("Date: \(story.date?.longDate ?? "Unknown")")
                    Text(story.date ?? Date(), style: .time)
                }
                .lineLimit(1)
                .font(.system(size: 16, weight: .ultraLight))
            }
            Spacer()
            VStack(alignment: .trailing) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 44, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            gameManager.mainColorSheme(color: .blue)
                        )
                Spacer()
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
    }
}
