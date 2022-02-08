//
//  FBFriendRequest.swift
//  CoachApp
//
//  Created by Иван Маришин on 05.12.2021.
//

import Foundation

struct FBFriendRequest {
    let sendID: String
    let sendName: String
    let receiveID: String
    let receiveName: String
    
    // App Specific properties can be added here
    
    init(sendID: String, sendName: String, receiveID: String, receiveName: String) {
        self.sendID = sendID
        self.sendName = sendName
        self.receiveID = receiveID
        self.receiveName = receiveName
    }
    
}

extension FBFriendRequest {
    init?(documentData: [String : Any]) {
        let sendID = documentData[FBKeys.FriendRequest.sendID] as? String ?? ""
        let sendName = documentData[FBKeys.FriendRequest.sendName] as? String ?? ""
        let receiveID = documentData[FBKeys.FriendRequest.receiveID] as? String ?? ""
        let receiveName = documentData[FBKeys.FriendRequest.receiveName] as? String ?? ""
        
        // Make sure you also initialize any app specific properties if you have them
        
        
        self.init(sendID: sendID, sendName: sendName, receiveID: receiveID, receiveName: receiveName)
    }
    
    static func dataDict(sendID: String, sendName: String, receiveID: String, receiveName: String) -> [String: Any] {
        var data: [String: Any]
        
        data = [
            FBKeys.FriendRequest.sendID: sendID,
            FBKeys.FriendRequest.sendName: sendName,
            FBKeys.FriendRequest.receiveID: receiveID,
            FBKeys.FriendRequest.receiveName: receiveName,
        ]
        return data
    }
}
