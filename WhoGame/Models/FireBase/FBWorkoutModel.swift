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
    var date: Date
    var type: Int
    var name: String
    var theme: String
    var showAnswer: Bool
    var showHelp: Bool
    var showScore: Bool
}

struct Exercise: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var result: Bool
    var order: Int
    var type: Int
    var workoutId: String
    var sets: Int?
    var setsResult: Int?
    var reps: Int?
    var weight: Double?
    var weightValue: Int?
    var distance: Double?
    var distanceValue: Int?
    var hours: Int?
    var minutes: Int?
}
