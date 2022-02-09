//
//  FBExercise.swift
//  CoachApp
//
//  Created by Иван Маришин on 06.12.2021.
//

import Foundation

struct FBGameCard {
    let answer: String
    let fakeAnswerFourth: String
    let fakeAnswerSecond: String
    let fakeAnswerThird: String
    let gameId: String
    let help: String
    let mark: Int
    let question: String
    let result: Bool
    let score: Int
    
    // App Specific properties can be added here
    
    init(answer: String, fakeAnswerFourth: String, fakeAnswerSecond: String, fakeAnswerThird: String, gameId: String, help: String, mark: Int, question: String, result: Bool, score: Int) {
        self.answer = answer
        self.fakeAnswerFourth = fakeAnswerFourth
        self.fakeAnswerSecond = fakeAnswerSecond
        self.fakeAnswerThird = fakeAnswerThird
        self.gameId = gameId
        self.help = help
        self.mark = mark
        self.question = question
        self.result = result
        self.score = score
    }
    
}

extension FBGameCard {
    init?(documentData: [String : Any]) {
        let answer = documentData[FBKeys.GameCard.answer] as? String ?? ""
        let fakeAnswerFourth = documentData[FBKeys.GameCard.fakeAnswerFourth] as? String ?? ""
        let fakeAnswerSecond = documentData[FBKeys.GameCard.fakeAnswerSecond] as? String ?? ""
        let fakeAnswerThird = documentData[FBKeys.GameCard.fakeAnswerThird] as? String ?? ""
        let gameId = documentData[FBKeys.GameCard.gameId] as? String ?? ""
        let help = documentData[FBKeys.GameCard.help] as? String ?? ""
        let mark = documentData[FBKeys.GameCard.mark] as? Int ?? 0
        let question = documentData[FBKeys.GameCard.question] as? String ?? ""
        let result = documentData[FBKeys.GameCard.result] as? Bool ?? false
        let score = documentData[FBKeys.GameCard.score] as? Int ?? 0
        
        // Make sure you also initialize any app specific properties if you have them
        
        
        self.init(answer: answer, fakeAnswerFourth: fakeAnswerFourth, fakeAnswerSecond: fakeAnswerSecond, fakeAnswerThird: fakeAnswerThird, gameId: gameId, help: help, mark: mark, question: question, result: result, score: score)
    }
    
    static func dataDict(answer: String, fakeAnswerFourth: String, fakeAnswerSecond: String, fakeAnswerThird: String, gameId: String, help: String, mark: Int, question: String, result: Bool, score: Int) -> [String: Any] {
        var data: [String: Any]
        
        data = [
            FBKeys.GameCard.answer: answer,
            FBKeys.GameCard.fakeAnswerFourth: fakeAnswerFourth,
            FBKeys.GameCard.fakeAnswerSecond: fakeAnswerSecond,
            FBKeys.GameCard.fakeAnswerThird: fakeAnswerThird,
            FBKeys.GameCard.gameId: gameId,
            FBKeys.GameCard.help: help,
            FBKeys.GameCard.mark: mark,
            FBKeys.GameCard.question: question,
            FBKeys.GameCard.result: result,
            FBKeys.GameCard.score: score
        ]
        return data
    }
}

