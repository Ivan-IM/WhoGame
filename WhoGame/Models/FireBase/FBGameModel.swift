//
//  Workout.swift
//  CoachApp
//
//  Created by Иван Маришин on 31.10.2021.
//

import Foundation
import FirebaseFirestoreSwift

struct Game: Codable, Identifiable {
    @DocumentID var id: String?
    var author: String
    var authorName: String?
    var date: Date
    var type: Int
    var name: String
    var theme: String
    var showAnswer: Bool
    var showHelp: Bool
    var showScore: Bool
}

struct GameCard: Codable, Identifiable {
    @DocumentID var id: String?
    var answer: String
    var fakeAnswerFourth: String
    var fakeAnswerSecond: String
    var fakeAnswerThird: String
    var gameId: String
    var help: String
    var mark: Int
    var question: String
    var score: Int
}
