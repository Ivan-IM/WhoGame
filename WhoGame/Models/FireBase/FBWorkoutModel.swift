//
//  Workout.swift
//  CoachApp
//
//  Created by Иван Маришин on 31.10.2021.
//

import Foundation
import FirebaseFirestoreSwift

struct Workout: Codable, Identifiable {
    @DocumentID var id: String?
    var author: String
    var date: Date
    var type: Int
    var comment: String
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
