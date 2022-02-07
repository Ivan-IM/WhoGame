//
//  MainView.swift
//  WhoGame
//
//  Created by Иван Маришин on 05.12.2021.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @State var translation: CGSize = .zero
    
    var body: some View {
        ZStack {
            UserInfoView()
            Group {
                GameMenuView()
            }
            .mask(RoundedRectangle(cornerRadius: 34))
            .shadow(color: .secondary.opacity(0.8), radius: 15, x: -5, y: -5)
            .offset(x: translation.width + gameManager.offSetX)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        translation = value.translation
                    })
                    .onEnded({ value in
                        withAnimation {
                            let snap = translation.width + gameManager.offSetX
                            
                            if snap > 35 {
                                gameManager.offSetX = 70
                            } else {
                                gameManager.offSetX = 0
                            }
                            translation = .zero
                        }
                    })
            )
            .ignoresSafeArea()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(GameManager())
            .preferredColorScheme(.light)
    }
}
