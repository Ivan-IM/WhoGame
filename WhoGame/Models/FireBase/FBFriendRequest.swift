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
    let sendEmail: String
    let receiveID: String
    let receiveName: String
    let receiveEmail: String
    
    // App Specific properties can be added here
    
    init(sendID: String, sendName: String, sendEmail: String, receiveID: String, receiveName: String, receiveEmail: String) {
        self.sendID = sendID
        self.sendName = sendName
        self.sendEmail = sendEmail
        self.receiveID = receiveID
        self.receiveName = receiveName
        self.receiveEmail = receiveEmail
    }
    
}

extension FBFriendRequest {
    init?(documentData: [String : Any]) {
        let sendID = documentData[FBKeys.FriendRequest.sendID] as? String ?? ""
        let sendName = documentData[FBKeys.FriendRequest.sendName] as? String ?? ""
        let sendEmail = documentData[FBKeys.FriendRequest.sendEmail] as? String ?? ""
        let receiveID = documentData[FBKeys.FriendRequest.receiveID] as? String ?? ""
        let receiveName = documentData[FBKeys.FriendRequest.receiveName] as? String ?? ""
        let receiveEmail = documentData[FBKeys.FriendRequest.receiveEmail] as? String ?? ""
        
        // Make sure you also initialize any app specific properties if you have them
        
        
        self.init(sendID: sendID, sendName: sendName, sendEmail: sendEmail, receiveID: receiveID, receiveName: receiveName, receiveEmail: receiveEmail)
    }
    
    static func dataDict(sendID: String, sendName: String, sendEmail: String, receiveID: String, receiveName: String, receiveEmail: String) -> [String: Any] {
        var data: [String: Any]
        
        data = [
            FBKeys.FriendRequest.sendID: sendID,
            FBKeys.FriendRequest.sendName: sendName,
            FBKeys.FriendRequest.sendEmail: sendEmail,
            FBKeys.FriendRequest.receiveID: receiveID,
            FBKeys.FriendRequest.receiveName: receiveName,
            FBKeys.FriendRequest.receiveEmail: receiveEmail
        ]
        return data
    }
}
