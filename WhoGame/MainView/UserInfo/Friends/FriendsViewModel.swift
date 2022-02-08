//
//  FriendsViewModel.swift
//  WhoGame
//
//  Created by Иван Маришин on 08.02.2022.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

final class FriendsViewModel: ObservableObject {
    
    @Published var uid: String = ""
    @Published var userId: String = ""
    @Published var searchUserName: String = ""
    @Published var showingSearch: Bool = false
    
    @Published var friendRequests = [FriendRequest]()
    
    @Published var searchUser: FBUser = .init(uid: "", name: "", email: "")
    @Published var hideSearchUser: Bool = false
    
    private let store = Firestore.firestore()
    
    @Published var friends = [Friend]()
    
    init() {
        self.uid = Auth.auth().currentUser?.uid ?? ""
        getFriends()
        getFriendRequests()
    }
    
    func getFriends() {
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
    
    func getFriendRequests() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        var requests = [FriendRequest]()
        
        Firestore.firestore().collection(FBKeys.CollectionPath.friendRequest).addSnapshotListener { (snapshot, error) in
            switch error {
            case .none:
                requests = snapshot?.documents.compactMap {
                    try? $0.data(as: FriendRequest.self)
                } ?? []
                self.friendRequests = requests.filter{ $0.receiveID == currentUserId }
            case .some(_):
                print("\(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    func search() {
        if !self.userId.isEmpty {
            FBFirestore.retrieveFBUser(uid: self.userId) { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let user):
                    self.searchUser = user
                    self.searchUserName = user.name
                }
            }
        }
    }
    
    func addFriendRequest() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        FBFirestore.retrieveFBUser(uid: currentUserId) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let user):
                let data = FBFriendRequest.dataDict(sendID: user.uid, sendName: user.name, receiveID: self.searchUser.uid, receiveName: self.searchUser.name)
                
                FBFirestore.mergeFBFriendRequest(data, uid: currentUserId+self.searchUser.uid) { (result) in
                    switch result {
                    case .success(_):
                        self.hideSearchUser = true
                        self.userId = ""
                    case .failure(_):
                        self.hideSearchUser = false
                    }
                }
            }
        }
    }
    
    func addFriend(_ friendRequest: FriendRequest) {
        let sendData = FBUser.dataDict(uid: friendRequest.sendID, name: friendRequest.sendName, email: "")
        let receiveData = FBUser.dataDict(uid: friendRequest.receiveID, name: friendRequest.receiveName, email: "")
        
        FBFirestore.mergeFBFriend(sendData, sendUid: friendRequest.sendID, receiveUid: friendRequest.receiveID) { (result) in
            switch result {
            case .success(_):
                print("friend add")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        FBFirestore.mergeFBFriend(receiveData, sendUid: friendRequest.receiveID, receiveUid: friendRequest.sendID) { (result) in
            switch result {
            case .success(_):
                print("friend add")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        removeFriendRequest(friendRequest)
    }
    
    func removeFriendRequest(_ friendRequest: FriendRequest) {
        guard let requestId = friendRequest.id else { return }
        store.collection(FBKeys.CollectionPath.friendRequest).document(requestId).delete { error in
            if let error = error {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func removeFriend(_ friend: Friend) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        guard let friendId = friend.id else { return }
        store.collection("friends/\(currentUserId)/friendsList").document(friendId).delete { error in
            if let error = error {
                print("\(error.localizedDescription)")
            }
        }
        store.collection("friends/\(friendId)/friendsList").document(currentUserId).delete { error in
            if let error = error {
                print("\(error.localizedDescription)")
            }
        }
    }
}


