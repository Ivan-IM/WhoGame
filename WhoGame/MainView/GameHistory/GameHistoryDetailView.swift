//
//  GameHistoryDetailView.swift
//  WhoGame
//
//  Created by Иван Маришин on 18.01.2022.
//

import SwiftUI

struct GameHistoryDetailView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @Environment(\.presentationMode) var presentationMode
    @State var showingDaleteAlert = false
    var story: GameHistoryCD
    
    var body: some View {
        ZStack {
            BackgroundView()
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
                        showingDaleteAlert = true
                    } label: {
                        Image(systemName: "trash")
                            .font(.system(size: 32, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .red)
                            )
                    }
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
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                .alert("Delete history?", isPresented: $showingDaleteAlert) {
                    Button("OK", role: .destructive) {
                        PersistenceController.shared.delete(story)
                        presentationMode.wrappedValue.dismiss()
                    }
                    Button("Cancel", role: .cancel) {}
                }
                ScrollView(showsIndicators: false) {
                    if let answers = story.answersHistory {
                        ForEach(0..<answers.count) { index in
                            HStack {
                                Text("\(index+1).")
                                Text("\(story.answersHistory?[index] ?? "Unknown")")
                                    .lineLimit(1)
                                Spacer()
                                Group {
                                    if story.gameType != 3 {
                                        if story.answersHistory?[index] == story.rightAnswersHistory?[index] {
                                            Image(systemName: "checkmark")
                                                .symbolVariant(.circle.fill)
                                                .symbolRenderingMode(.palette)
                                                .foregroundStyle(
                                                    Color.white.opacity(0.8),
                                                    gameManager.mainColorSheme(color: .green)
                                                )
                                        } else {
                                            Image(systemName: "xmark")
                                                .symbolVariant(.circle.fill)
                                                .symbolRenderingMode(.palette)
                                                .foregroundStyle(
                                                    Color.white.opacity(0.8),
                                                    gameManager.mainColorSheme(color: .red)
                                                )
                                        }
                                    }
                                }
                            }
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.primary)
                            .padding()
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .padding()
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
