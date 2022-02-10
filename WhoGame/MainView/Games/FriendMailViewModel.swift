//
//  FriendRequestViewModel.swift
//  WhoGame
//
//  Created by Иван Маришин on 09.02.2022.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

final class FriendMailViewModel: ObservableObject {
    
    @Published var friends = [Friend]()
    
    let game: GameCD
    @Published var gameCards = [GameCardCD]()
    
    init(game: GameCD) {
        self.game = game
        self.gameCards = fetchGameCards(game: game)
    }
    
    func fetchGameCards(game: GameCD) -> [GameCardCD] {
        if let gameId = game.id {
            return PersistenceController.shared.fetchGameCards(for: gameId)
        } else {
            return []
        }
    }
    
    func getFriends() {
        if friends.isEmpty {
            guard let currentUserId = Auth.auth().currentUser?.uid else { return }
            
            Firestore.firestore().collection("friends/\(currentUserId)/friendsList").addSnapshotListener { (snapshot, error) in
                switch error {
                case .none:
                    self.friends = snapshot?.documents.compactMap {
                        try? $0.data(as: Friend.self)
                    } ?? []
                case .some(_):
                    print("\(String(describing: error?.localizedDescription))")
                }
            }
        }
    }
    
    func sendGame(friend: Friend) {
            guard let gameId = self.game.id else { return }
            
        let dataGame = FBGame.dataDict(author: game.author ?? "", date: game.date ?? Date(), type: Int(game.type), name: game.name ?? "Unknown", theme: game.theme ?? "Unknown", showAnswer: game.showAnswer, showHelp: game.showHelp, showScore: game.showScore)
            
        FBFirestore.mergeFBGame(dataGame, userId: friend.uid, gameId: gameId) { (result) in
                    switch result {
                    case .success(_):
                        print("Game send")
                        
                        for gameCard in self.gameCards {
                            let dataGameCard = FBGameCard.dataDict(answer: gameCard.answer ?? "", fakeAnswerFourth: gameCard.fakeAnswerFourth ?? "", fakeAnswerSecond: gameCard.fakeAnswerSecond ?? "", fakeAnswerThird: gameCard.fakeAnswerThird ?? "", gameId: gameId, help: gameCard.help ?? "", mark: Int(gameCard.mark), question: gameCard.question ?? "", result: gameCard.result, score: Int(gameCard.score))
                            
                            FBFirestore.mergeFBGameCard(dataGameCard, userId: friend.uid, gameId: gameId, gameCardId: gameCard.id ?? "") { (result) in
                                switch result {
                                case .success(_):
                                    print("Exercise send")
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                            }
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
    }
}
