//
//  FriendSendGameListCellView.swift
//  WhoGame
//
//  Created by Иван Маришин on 12.02.2022.
//

import SwiftUI

struct FriendSendGameListCellView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @EnvironmentObject var fbManager: FBManager
    @State var sending: Bool = false
    let game: GameCD
    let friendId: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text("\(game.name ?? "Unknown")")
                    .lineLimit(1)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(
                        gameManager.mainColorSheme(color: .blue)
                    )
                Text("Theme: \(game.theme ?? "Unknown")")
                    .lineLimit(1)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.secondary)
                Text("Questions: \(PersistenceController.shared.fetchGameCards(for: game.id ?? "").count)")
                    .lineLimit(1)
                    .font(.system(size: 16, weight: .ultraLight))
                    .foregroundColor(PersistenceController.shared.fetchGameCards(for: game.id ?? "").isEmpty ? .red:.primary)
            }
            Spacer()
            if game.favorite {
                    Image(systemName: "star")
                        .font(.system(size: 24, weight: .regular))
                        .symbolVariant(.fill)
                        .foregroundColor(.yellow)
            }
            Button {
                guard let gameId = self.game.id else { return }
                sending = true
                let dataGame = FBGame.dataDict(author: checkEmpty(checkValue: game.author ?? "", optionalValue: fbManager.uid), authorName: checkEmpty(checkValue: game.authorName ?? "", optionalValue: fbManager.userName), date: Date(), type: Int(game.type), name: game.name ?? "Unknown", theme: game.theme ?? "Unknown", showAnswer: game.showAnswer, showHelp: game.showHelp, showScore: game.showScore)
                
                FBFirestore.mergeFBGame(dataGame, userId: friendId, gameId: gameId) { (result) in
                    switch result {
                    case .success(_):
                        print("Game send")
                        
                        for gameCard in PersistenceController.shared.fetchGameCards(for: gameId) {
                            let dataGameCard = FBGameCard.dataDict(answer: gameCard.answer ?? "", fakeAnswerFourth: gameCard.fakeAnswerFourth ?? "", fakeAnswerSecond: gameCard.fakeAnswerSecond ?? "", fakeAnswerThird: gameCard.fakeAnswerThird ?? "", gameId: gameId, help: gameCard.help ?? "", mark: Int(gameCard.mark), question: gameCard.question ?? "", score: Int(gameCard.score))
                            
                            FBFirestore.mergeFBGameCard(dataGameCard, userId: friendId, gameId: gameId, gameCardId: gameCard.id ?? "") { (result) in
                                switch result {
                                case .success(_):
                                    print("GameCard send")
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                            }
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Image(systemName: sending ? "checkmark":"paperplane")
                    .font(.system(size: 44, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        gameManager.mainColorSheme(color: sending ? .green:.blue)
                    )
            }
            .disabled(sending)
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
    }
    
    private func checkEmpty(checkValue: String, optionalValue: String) -> String {
        if checkValue.isEmpty {
            return optionalValue
        } else {
            return checkValue
        }
    }
}
