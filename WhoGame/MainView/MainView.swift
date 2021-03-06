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
        ZStack(alignment: .leading) {
            GameMenuView()
            Group {
                if gameManager.showingUserInfoPanel {
                    UserInfoPanelView()
                        .offset(x: translation.width + gameManager.offSetX)
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    translation = value.translation
                                })
                                .onEnded({ value in
                                    withAnimation {
                                        gameManager.offSetX = -gameManager.width
                                        gameManager.showingUserInfoPanel = false
                                        translation = .zero
                                    }
                                })
                        )
                        .transition(.move(edge: .leading))
                        .animation(.default, value: gameManager.showingUserInfoPanel)
                        .zIndex(1)
                    
                }
            }
            Group {
                if gameManager.showingFriendsView {
                    FriendsView()
                        .transition(.move(edge: .trailing))
                        .animation(.default, value: gameManager.showingFriendsView)
                        .zIndex(2)
                }
                if gameManager.showingMailView {
                    GameMailView()
                        .transition(.move(edge: .trailing))
                        .animation(.default, value: gameManager.showingMailView)
                        .zIndex(3)
                }
                if gameManager.showingUserInfoView {
                    UserInfoView()
                        .transition(.move(edge: .trailing))
                        .animation(.default, value: gameManager.showingUserInfoView)
                        .zIndex(4)
                }
            }
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
