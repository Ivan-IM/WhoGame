//
//  BackgroundView.swift
//  WhoGame
//
//  Created by Иван Маришин on 16.01.2022.
//

import SwiftUI

struct BackgroundView: View {
    
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        ZStack {
            Path { path in
                path.move(to: CGPoint(x: 0, y: gameManager.height))
                path.addLine(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: gameManager.width, y: gameManager.height*0.93))
                path.addLine(to: CGPoint(x: gameManager.width, y: gameManager.height))
                path.closeSubpath()
            }
            .fill(
                LinearGradient(colors: [Color("white"), .teal, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .shadow(color: .black.opacity(0.8), radius: 5, x: 0, y: 5)
            Path { path in
                path.move(to: CGPoint(x: 0, y: gameManager.height))
                path.addLine(to: CGPoint(x: 0, y: gameManager.height*0.40))
                path.addLine(to: CGPoint(x: gameManager.width, y: gameManager.height*0.93))
                path.addLine(to: CGPoint(x: gameManager.width, y: gameManager.height))
                path.closeSubpath()
            }
            .fill(
                LinearGradient(colors: [Color("white"), .yellow, .orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .shadow(color: .black.opacity(0.8), radius: 5, x: 2.5, y: 5)
            Path { path in
                path.move(to: CGPoint(x: 0, y: gameManager.height))
                path.addLine(to: CGPoint(x: 0, y: gameManager.height*0.70))
                path.addLine(to: CGPoint(x: gameManager.width, y: gameManager.height*0.93))
                path.addLine(to: CGPoint(x: gameManager.width, y: gameManager.height))
                path.closeSubpath()
            }
            .fill(
                LinearGradient(colors: [Color("white"), .mint, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .shadow(color: .black.opacity(0.8), radius: 5, x: 5, y: 5)
        }
        .background(
            LinearGradient(colors: [Color("white"), .teal], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
            .environmentObject(GameManager())
            .preferredColorScheme(.light)
    }
}
