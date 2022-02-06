//
//  FBExercise.swift
//  CoachApp
//
//  Created by Иван Маришин on 06.12.2021.
//

import Foundation

struct FBExercise {
    let name: String
    let result: Bool
    let order: Int
    let type: Int
    let workoutId: String
    let sets: Int
    let setsResult: Int
    let reps: Int
    let weight: Double
    let weightValue: Int
    let distance: Double
    let distanceValue: Int
    let hours: Int
    let minutes: Int
    
    // App Specific properties can be added here
    
    init(name: String, result: Bool, order: Int, type: Int, workoutId: String, sets: Int, setsResult: Int, reps: Int, weight: Double, weightValue: Int, distance: Double, distanceValue: Int, hours: Int, minutes: Int) {
        self.name = name
        self.result = result
        self.order = order
        self.type = type
        self.workoutId = workoutId
        self.sets = sets
        self.setsResult = setsResult
        self.reps = reps
        self.weight = weight
        self.weightValue = weightValue
        self.distance = distance
        self.distanceValue = distanceValue
        self.hours = hours
        self.minutes = minutes
    }
    
}

extension FBExercise {
    init?(documentData: [String : Any]) {
        let name = documentData[FBKeys.Exercise.name] as? String ?? ""
        let result = documentData[FBKeys.Exercise.result] as? Bool ?? false
        let order = documentData[FBKeys.Exercise.order] as? Int ?? 0
        let type = documentData[FBKeys.Exercise.type] as? Int ?? 0
        let workoutId = documentData[FBKeys.Exercise.workoutId] as? String ?? ""
        let sets = documentData[FBKeys.Exercise.sets] as? Int ?? 0
        let setsResult = documentData[FBKeys.Exercise.setsResult] as? Int ?? 0
        let reps = documentData[FBKeys.Exercise.reps] as? Int ?? 0
        let weight = documentData[FBKeys.Exercise.weight] as? Double ?? 0
        let weightValue = documentData[FBKeys.Exercise.weightValue] as? Int ?? 0
        let distance = documentData[FBKeys.Exercise.distance] as? Double ?? 0
        let distanceValue = documentData[FBKeys.Exercise.distanceValue] as? Int ?? 0
        let hours = documentData[FBKeys.Exercise.hours] as? Int ?? 0
        let minutes = documentData[FBKeys.Exercise.minutes] as? Int ?? 0
        
        // Make sure you also initialize any app specific properties if you have them
        
        
        self.init(name: name, result: result, order: order, type: type, workoutId: workoutId, sets: sets, setsResult: setsResult, reps: reps, weight: weight, weightValue: weightValue, distance: distance, distanceValue: distanceValue, hours: hours, minutes: minutes)
    }
    
    static func dataDict(name: String, result: Bool, order: Int, type: Int, workoutId: String, sets: Int, setsResult: Int, reps: Int, weight: Double, weightValue: Int, distance: Double, distanceValue: Int, hours: Int, minutes: Int) -> [String: Any] {
        var data: [String: Any]
        
        data = [
            FBKeys.Exercise.name: name,
            FBKeys.Exercise.result: result,
            FBKeys.Exercise.order: order,
            FBKeys.Exercise.type: type,
            FBKeys.Exercise.workoutId: workoutId,
            FBKeys.Exercise.sets: sets,
            FBKeys.Exercise.setsResult: setsResult,
            FBKeys.Exercise.reps: reps,
            FBKeys.Exercise.weight: weight,
            FBKeys.Exercise.weightValue: weightValue,
            FBKeys.Exercise.distance: distance,
            FBKeys.Exercise.distanceValue: distanceValue,
            FBKeys.Exercise.hours: hours,
            FBKeys.Exercise.minutes: minutes
        ]
        return data
    }
}

