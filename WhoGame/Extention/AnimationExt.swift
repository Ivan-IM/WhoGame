//
//  AnimationExt.swift
//  WhoGame
//
//  Created by Иван Маришин on 04.03.2022.
//

import SwiftUI

struct Shake: AnimatableModifier {
    
    var shakeNumber: CGFloat = 0
    
    var animatableData: CGFloat {
        get {
            shakeNumber
        } set {
            shakeNumber = newValue
        }
    }
    
    func body(content: Content) -> some View {
        content
            .offset(x: sin(shakeNumber * .pi * 2) * 3)
    }
}
