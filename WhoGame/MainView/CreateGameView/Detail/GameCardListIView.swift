//
//  GameCardListIView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.01.2022.
//

import SwiftUI

struct GameCardListIView: View {
    
    @EnvironmentObject var gameManager: GameManager
    let editMode: Bool
    let gameId: String
    let showScore: Bool
    let showHelp: Bool
    let gameType: Int
    var gameCardRequest : FetchRequest<GameCardCD>
    var gameCards : FetchedResults<GameCardCD>{gameCardRequest.wrappedValue}
    
    init(gameId: String, gameType: Int, editMode: Bool, showScore: Bool, showHelp: Bool) {
        self.gameId = gameId
        self.editMode = editMode
        self.gameCardRequest = FetchRequest(entity: GameCardCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GameCardCD.mark, ascending: true)], predicate: NSPredicate(format: "gameId == %@", gameId))
        self.showScore = showScore
        self.showHelp = showHelp
        self.gameType = gameType
    }
    
    var body: some View {
        ScrollView {
            ForEach(gameCards) { card in
                if editMode {
                    HStack {
                        Text("\(card.mark).")
                            .fontWeight(.semibold)
                        Text("\(card.question ?? "Unknown")")
                            .lineLimit(1)
                        Spacer()
                        if card.mark != gameCards.count {
                            Button {
                                moveGameCardDown(gameCard: card)
                            } label: {
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 18, weight: .regular))
                                    .symbolVariant(.circle.fill)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(
                                        Color.white.opacity(0.8),
                                        gameManager.mainColorSheme(color: .red)
                                    )
                            }
                        }
                        if card.mark > 1 {
                            Button {
                                moveGameCardUp(gameCard: card)
                            } label: {
                                Image(systemName: "chevron.up")
                                    .font(.system(size: 18, weight: .regular))
                                    .symbolVariant(.circle.fill)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(
                                        Color.white.opacity(0.8),
                                        gameManager.mainColorSheme(color: .red)
                                    )
                            }
                        }
                    }
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.primary)
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                } else {
                    NavigationLink {
                        EditGameCardView(viewModel: NewGameCardViewModel(gameCard: card, gameType: gameType, showScore: showScore, showHelp: showHelp))
                    } label: {
                        HStack {
                            Text("\(card.mark).")
                                .fontWeight(.semibold)
                            Text("\(card.question ?? "Unknown")")
                                .lineLimit(1)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 18, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    gameManager.mainColorSheme(color: .blue)
                                )
                        }
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.primary)
                    }
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                }
            }
//            .onMove(perform: moveGameCard)
//            .onDelete(perform: removeGameCard)
        }
    }
    
    private func moveGameCardUp(gameCard: GameCardCD) {
        self.gameCards[Int(gameCard.mark-2)].mark += 1
        gameCard.mark -= 1
        PersistenceController.shared.save()
    }
    
    private func moveGameCardDown(gameCard: GameCardCD) {
        self.gameCards[Int(gameCard.mark)].mark -= 1
        gameCard.mark += 1
        PersistenceController.shared.save()
    }
    
    private func moveGameCard(from source: IndexSet, to destination: Int) {
        if source.first! > destination {
            gameCards[source.first!].mark = gameCards[destination].mark - 1
            for i in destination...gameCards.count - 1 {
                gameCards[i].mark = gameCards[i].mark + 1
            }
        }
        if source.first! < destination {
            gameCards[source.first!].mark = gameCards[destination - 1].mark + 1
            for i in 0...destination - 1 {
                gameCards[i].mark = gameCards[i].mark - 1
            }
        }
        PersistenceController.shared.save()
    }
    
    private func removeGameCard(at offsets: IndexSet) {
        for index in offsets {
            let gameCard = gameCards[index]
            PersistenceController.shared.delete(gameCard)
            for card in gameCards {
                if card.mark > index+1 {
                    card.mark -= 1
                    PersistenceController.shared.save()
                }
            }
        }
    }
}

struct GameCardListIView_Previews: PreviewProvider {
    static var previews: some View {
        GameCardListIView(gameId: "", gameType: 0, editMode: true, showScore: true, showHelp: true)
    }
}
