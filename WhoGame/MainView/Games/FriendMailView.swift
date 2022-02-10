//
//  FriendRequestView.swift
//  WhoGame
//
//  Created by Иван Маришин on 09.02.2022.
//

import SwiftUI

struct FriendMailView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @ObservedObject var viewModel: FriendMailViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                HStack {
                    Text("Friends")
                        .lineLimit(1)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(
                            gameManager.mainColorSheme(color: .blue)
                        )
                    Spacer()
                    Button {
                        withAnimation {
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Image(systemName: "multiply.circle")
                            .font(.system(size: 32, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .blue)
                            )
                    }
                }
                ScrollView(showsIndicators: false) {
                    ForEach(viewModel.friends) { friend in
                        FriendMailCellView(viewModel: viewModel, friend: friend)
                    }
                    .padding(.bottom, 32)
                }
            }
            .padding()
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
            .background(
                RoundedRectangle(cornerRadius: 34)
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
            )
            .onAppear {
                viewModel.getFriends()
            }
        }
    }
}
