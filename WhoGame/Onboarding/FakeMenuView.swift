//
//  FakeMenuView.swift
//  WhoGame
//
//  Created by Иван Маришин on 23.03.2022.
//

import SwiftUI

struct FakeMenuView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @State private var animateCreate = false
    @State private var animatePlay = false
    @State private var animateHistory = false
    @State private var animateW = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "w")
                        .font(.system(size: 44, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            Color.blue.opacity(0.9)
                        )
                        .scaleEffect(animateW ? 1.3:1.0)
                        .animation(animateW ? .easeInOut(duration: 1).repeatForever(autoreverses: true) : .default, value: animateW)
                    Image(systemName: "h")
                        .font(.system(size: 44, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            Color.orange.opacity(0.9)
                        )
                    Image(systemName: "o")
                        .font(.system(size: 44, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            Color.green.opacity(0.9)
                        )
                }
                Spacer()
                
                Image(systemName: "play")
                    .font(.system(size: 88, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        Color.blue
                    )
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                    .offset(x: gameManager.width*0.22)
                    .scaleEffect(animatePlay ? 1.2:1.0)
                    .animation(animatePlay ? .easeInOut(duration: 1).repeatForever(autoreverses: true) : .default, value: animatePlay)
                
                
                Image(systemName: "plus")
                    .font(.system(size: 88, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        Color.orange
                    )
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                    .scaleEffect(animateCreate ? 1.2:1.0)
                    .animation(animateCreate ? .easeInOut(duration: 1).repeatForever(autoreverses: true) : .default, value: animateCreate)
                
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 88, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        Color.green
                    )
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                    .offset(x: -gameManager.width*0.22)
                    .scaleEffect(animateHistory ? 1.2:1.0)
                    .animation(animateHistory ? .easeInOut(duration: 1).repeatForever(autoreverses: true) : .default, value: animateHistory)
            }
            .padding()
        }
        .mask(RoundedRectangle(cornerRadius: 34))
        .scaleEffect(0.7)
        .onAppear {
            withAnimation {
                animateCreate = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
                withAnimation {
                    animateCreate = false
                    animatePlay = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 25) {
                withAnimation {
                    animatePlay = false
                    animateHistory = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 35) {
                withAnimation {
                    animateHistory = false
                    animateW = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 45) {
                withAnimation {
                    animateW = false
                }
            }
        }
    }
}

struct FakeMenuView_Previews: PreviewProvider {
    static var previews: some View {
        FakeMenuView()
            .environmentObject(GameManager())
    }
}
