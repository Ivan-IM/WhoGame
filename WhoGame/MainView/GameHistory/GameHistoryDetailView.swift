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
                GameHistoryCellView(story: story, showImage: false)
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
                                        if story.answersHistory?[index].caseInsensitiveCompare(story.rightAnswersHistory?[index] ?? "") == .orderedSame {
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
            .alert("Delete history?", isPresented: $showingDaleteAlert) {
                Button("OK", role: .destructive) {
                    PersistenceController.shared.delete(story)
                    presentationMode.wrappedValue.dismiss()
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
}
