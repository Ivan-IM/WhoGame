//
//  GameMailViewModel.swift
//  WhoGame
//
//  Created by Иван Маришин on 08.02.2022.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

final class GameMailViewModel: ObservableObject {
    
    @Published var games = [Game]()
    @Published var friends = [Friend]()
    
    init() {
        getGames()
        getFriends()
    }
    
    func getGames() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("games/\(currentUserId)/games").addSnapshotListener { (snapshot, error) in
            switch error {
            case .none:
                self.games = snapshot?.documents.compactMap {
                    try? $0.data(as: Game.self)
                } ?? []
                
            case .some(_):
                print("\(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    func removeGame(game: Game) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        guard let gameId = game.id else { return }
        
        Firestore.firestore().collection("games/\(currentUserId)/games").document(gameId).delete { error in
            if let error = error {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func addGame(game: Game) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        guard let gameId = game.id else { return }
        var gameCards = [GameCard]()
        
        Firestore.firestore().collection("games/\(currentUserId)/games/\(gameId)/gameCards").addSnapshotListener { (snapshot, error) in
            switch error {
            case .none:
                gameCards = snapshot?.documents.compactMap {
                    try? $0.data(as: GameCard.self)
                } ?? []
                
                let newGame = GameCD(context: PersistenceController.shared.container.viewContext)
                newGame.id = gameId
                newGame.favorite = false
                newGame.author = game.author
                newGame.date = game.date
                newGame.type = Int64(game.type)
                newGame.name = game.name
                newGame.theme = game.theme
                newGame.showAnswer = game.showAnswer
                newGame.showHelp = game.showHelp
                newGame.showScore = game.showScore
                
                PersistenceController.shared.save { error in
                    switch error {
                    case .none:
                        print("Game save")
                        for gameCard in gameCards {
                            let newGameCard = GameCardCD(context: PersistenceController.shared.container.viewContext)
                            newGameCard.id = gameCard.id ?? UUID().uuidString
                            newGameCard.answer = gameCard.answer
                            newGameCard.fakeAnswerFourth = gameCard.fakeAnswerFourth
                            newGameCard.fakeAnswerSecond = gameCard.fakeAnswerSecond
                            newGameCard.fakeAnswerThird = gameCard.fakeAnswerThird
                            newGameCard.gameId = newGame.id
                            newGameCard.help = gameCard.help
                            newGameCard.mark = Int64(gameCard.mark)
                            newGameCard.question = gameCard.question
                            newGameCard.result = gameCard.result
                            newGameCard.score = Int64(gameCard.score)
                            newGameCard.toGameCD = newGame
                            
                            PersistenceController.shared.save { error in
                                switch error {
                                case .none:
                                    print("GameCard save")
                                case .some(_):
                                    print(String(describing: error?.localizedDescription))
                                }
                            }
                        }
                    case .some(_):
                        print(String(describing: error?.localizedDescription))
                    }
                }
            case .some(_):
                print("\(String(describing: error?.localizedDescription))")
            }
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
}
