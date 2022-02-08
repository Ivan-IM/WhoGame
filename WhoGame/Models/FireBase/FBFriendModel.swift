//
//  FBUserModel.swift
//  CoachApp
//
//  Created by Иван Маришин on 28.11.2021.
//

import SwiftUI
import FirebaseFirestoreSwift


struct Friend: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var uid: String
}

struct FriendRequest: Codable, Identifiable {
    @DocumentID var id: String?
    var sendID: String
    var sendName: String
    var receiveID: String
    var receiveName: String
}
