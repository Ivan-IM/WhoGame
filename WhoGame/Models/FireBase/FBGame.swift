//
//  FBWorkout.swift
//  CoachApp
//
//  Created by Иван Маришин on 06.12.2021.
//

import Foundation

struct FBGame {
    let author: String
    let authorName: String
    let date: Date
    let type: Int
    let name: String
    let theme: String
    let showAnswer: Bool
    let showHelp: Bool
    let showScore: Bool
    
    
    // App Specific properties can be added here
    
    init(author: String, authorName: String, date: Date, type: Int, name: String, theme: String, showAnswer: Bool, showHelp: Bool, showScore: Bool) {
        self.author = author
        self.authorName = authorName
        self.date = date
        self.type = type
        self.name = name
        self.theme = theme
        self.showAnswer = showAnswer
        self.showHelp = showHelp
        self.showScore = showScore
    }
    
}

extension FBGame {
    init?(documentData: [String : Any]) {
        let author = documentData[FBKeys.Game.author] as? String ?? ""
        let authorName = documentData[FBKeys.Game.authorName] as? String ?? ""
        let date = documentData[FBKeys.Game.date] as? Date ?? Date().getGMTStartDate()
        let type = documentData[FBKeys.Game.type] as? Int ?? 0
        let name = documentData[FBKeys.Game.name] as? String ?? ""
        let theme = documentData[FBKeys.Game.theme] as? String ?? ""
        let showAnswer = documentData[FBKeys.Game.showAnswer] as? Bool ?? false
        let showHelp = documentData[FBKeys.Game.showHelp] as? Bool ?? false
        let showScore = documentData[FBKeys.Game.showScore] as? Bool ?? false
        // Make sure you also initialize any app specific properties if you have them
        
        self.init(author: author, authorName: authorName, date: date, type: type, name: name, theme: theme, showAnswer: showAnswer, showHelp: showHelp, showScore: showScore)
    }
    
    static func dataDict(author: String, authorName: String, date: Date, type: Int, name: String, theme: String, showAnswer: Bool, showHelp: Bool, showScore: Bool) -> [String: Any] {
        var data: [String: Any]
        
        data = [
            FBKeys.Game.author: author,
            FBKeys.Game.authorName: authorName,
            FBKeys.Game.date: date,
            FBKeys.Game.type: type,
            FBKeys.Game.name: name,
            FBKeys.Game.theme: theme,
            FBKeys.Game.showAnswer: showAnswer,
            FBKeys.Game.showHelp: showHelp,
            FBKeys.Game.showScore: showScore
        ]
        return data
    }
}
