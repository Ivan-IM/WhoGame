//
//  FBKeys.swift
//  Signin With Apple
//
//  Created by Stewart Lynch on 2020-03-18.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import Foundation

enum FBKeys {
    
    enum CollectionPath {
        static let users = "users"
        static let friends = "friends"
        static let friendRequest = "friendRequest"
    }
    
    enum User {
        static let uid = "uid"
        static let name = "name"
        static let email = "email"
    }
    
    enum FriendRequest {
        static let sendID = "sendID"
        static let sendName = "sendName"
        static let sendEmail = "sendEmail"
        static let receiveID = "receiveID"
        static let receiveName = "receiveName"
        static let receiveEmail = "receiveEmail"
    }
    
    enum Game {
        static let author = "author"
        static let date = "date"
        static let type = "type"
        static let name = "name"
        static let theme = "theme"
        static let showAnswer = "showAnswer"
        static let showHelp = "showHelp"
        static let showScore = "showScore"
    }
    
    enum GameCard {
        static let answer = "answer"
        static let fakeAnswerFourth = "fakeAnswerFourth"
        static let fakeAnswerSecond = "fakeAnswerSecond"
        static let fakeAnswerThird = "fakeAnswerThird"
        static let gameId = "gameId"
        static let help = "help"
        static let mark = "mark"
        static let question = "question"
        static let score = "score"
    }
}
