//
//  FBManager.swift
//  WhoGame
//
//  Created by Иван Маришин on 13.02.2022.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


final class FBManager: ObservableObject {
    
    @Published var uid: String {
        didSet {
            UserDefaults.standard.set(uid, forKey: "UID")
        }
    }
    @Published var userName: String {
        didSet {
            UserDefaults.standard.set(userName, forKey: "UserName")
        }
    }
    @Published var newMail: Int {
        didSet {
            UserDefaults.standard.set(newMail, forKey: "NewMail")
        }
    }
    @Published var user: FBUser = .init(uid: "", name: "", email: "")
    
    @Published var friendRequests = [FriendRequest]()
    @Published var friends = [Friend]()
    @Published var games = [Game]()
    
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        self.uid = UserDefaults.standard.object(forKey: "UID") as? String ?? ""
        self.userName = UserDefaults.standard.object(forKey: "UserName") as? String ?? ""
        self.newMail = UserDefaults.standard.object(forKey: "NewMail") as? Int ?? 0
    }
    
    func getFBData() {
        
        var requests = [FriendRequest]()
        
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ _, user in
            guard let user = user else { return }
            
            FBFirestore.retrieveFBUser(uid: user.uid) { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let user):
                    self.user = user
                    self.uid = user.uid
                    self.userName = user.name
                }
            }
            
            Firestore.firestore().collection("friends/\(user.uid)/friendsList").addSnapshotListener { (snapshot, error) in
                switch error {
                case .none:
                    self.friends = snapshot?.documents.compactMap {
                        try? $0.data(as: Friend.self)
                    } ?? []
                case .some(_):
                    print("\(String(describing: error?.localizedDescription))")
                }
            }
            
            Firestore.firestore().collection(FBKeys.CollectionPath.friendRequest).addSnapshotListener { (snapshot, error) in
                switch error {
                case .none:
                    requests = snapshot?.documents.compactMap {
                        try? $0.data(as: FriendRequest.self)
                    } ?? []
                    self.friendRequests = requests.filter{ $0.receiveID == user.uid }
                case .some(_):
                    print("\(String(describing: error?.localizedDescription))")
                }
            }
            
            Firestore.firestore().collection("games/\(user.uid)/games").addSnapshotListener { (snapshot, error) in
                switch error {
                case .none:
                    self.games = snapshot?.documents.compactMap {
                        try? $0.data(as: Game.self)
                    } ?? []
                case .some(_):
                    print("\(String(describing: error?.localizedDescription))")
                }
            }
        })
    }
    
    func deleteGame(game: GameCD) {
        guard let gameId = game.id else { return }
        let gameCards = PersistenceController.shared.fetchGameCards(for: gameId)
        PersistenceController.shared.delete(game) { error in
            switch error {
            case .none:
                for gameCard in gameCards {
                    PersistenceController.shared.delete(gameCard)
                }
            case .some(_):
                print(String(describing: error?.localizedDescription))
            }
        }
    }
    
    func clearFBmanager() {
        self.uid.removeAll()
        self.userName.removeAll()
        self.friendRequests.removeAll()
        self.friends.removeAll()
        self.games.removeAll()
    }
}
