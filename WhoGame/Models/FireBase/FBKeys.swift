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
    
    enum Workout {
        static let author = "author"
        static let athletes = "athletes"
        static let date = "date"
        static let name = "name"
        static let type = "type"
        static let comment = "comment"
    }
    
    enum Exercise {
        static let name = "name"
        static let result = "result"
        static let order = "order"
        static let type = "type"
        static let aerZone = "aerZone"
        static let workoutId = "workoutId"
        static let sets = "sets"
        static let setsResult = "setsResult"
        static let reps = "reps"
        static let weight = "weight"
        static let weightValue = "weightValue"
        static let distance = "distance"
        static let distanceValue = "distanceValue"
        static let hours = "hours"
        static let minutes = "minutes"
    }
}
