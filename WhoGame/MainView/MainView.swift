//
//  MainView.swift
//  WhoGame
//
//  Created by Иван Маришин on 05.12.2021.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @State var animate = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    ZStack {
                        Circle()
                            //.trim(from: 0.0, to: CGFloat(min(animate ? 1.0:0.0, 1.0)))
                            .stroke(.blue, lineWidth: 12)
                            .frame(width: 130, height: 130)
                        .offset(x: gameManager.width*0.22)
                    }
                    Circle()
                        .stroke(.purple, lineWidth: 16)
                        .frame(width: 130, height: 130)
                    Circle()
                        .stroke(.green, lineWidth: 16)
                        .frame(width: 130, height: 130)
                        .offset(x: -gameManager.width*0.22)
                }
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    NavigationLink {
                        GameListView(doYouWantToPlay: true)
                    } label: {
                        Text("Play")
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                            .frame(width: 130, height: 130)
                    }
                    .offset(x: gameManager.width*0.22)
                    .background(
                        Circle()
                            .frame(width: 130, height: 130)
                            .blur(radius: 6)
                            .blendMode(.overlay)
                            .offset(x: gameManager.width*0.22)
                    )
                    NavigationLink {
                        CreateGameView(viewModel: CreateGameViewModel())
                    } label: {
                        Text("Create")
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                            .frame(width: 130, height: 130)
                    }
                    .background(
                        Circle()
                            .frame(width: 130, height: 130)
                            .blur(radius: 6)
                            .blendMode(.overlay)
                    )
                    NavigationLink {
                        GameListView(doYouWantToPlay: false)
                    } label: {
                        Text("List")
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                            .frame(width: 130, height: 130)
                    }
                    .offset(x: -gameManager.width*0.22)
                    .background(
                        Circle()
                            .frame(width: 130, height: 130)
                            .blur(radius: 6)
                            .blendMode(.overlay)
                            .offset(x: -gameManager.width*0.22)
                    )
                }
                .navigationBarHidden(true)
            }
//            .animation(.easeInOut(duration: 3).repeatForever(), value: animate)
//            .onAppear() {
//                withAnimation {
//                    animate = true
//                }
//            }
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
