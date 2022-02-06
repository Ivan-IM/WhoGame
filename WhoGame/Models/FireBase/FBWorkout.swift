//
//  FBWorkout.swift
//  CoachApp
//
//  Created by Иван Маришин on 06.12.2021.
//

import Foundation

struct FBWorkout {
    let author: String
    let date: Date
    let type: Int
    let comment: String
    
    // App Specific properties can be added here
    
    init(author: String, date: Date, type: Int, comment: String) {
        self.author = author
        self.date = date
        self.type = type
        self.comment = comment
    }
    
}

extension FBWorkout {
    init?(documentData: [String : Any]) {
        let author = documentData[FBKeys.Workout.author] as? String ?? ""
        let date = documentData[FBKeys.Workout.date] as? Date ?? Date().getGMTStartDate()
        let type = documentData[FBKeys.Workout.type] as? Int ?? 0
        let comment = documentData[FBKeys.Workout.comment] as? String ?? ""
        // Make sure you also initialize any app specific properties if you have them
        
        
        self.init(author: author, date: date, type: type, comment: comment)
    }
    
    static func dataDict(author: String, date: Date, type: Int, comment: String) -> [String: Any] {
        var data: [String: Any]
        
        data = [
            FBKeys.Workout.author: author,
            FBKeys.Workout.date: date,
            FBKeys.Workout.type: type,
            FBKeys.Workout.comment: comment
        ]
        return data
    }
}
