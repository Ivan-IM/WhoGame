//
//  FriendCellView.swift
//  WhoGame
//
//  Created by Иван Маришин on 08.02.2022.
//

import SwiftUI

struct FriendCellView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @ObservedObject var viewModel: FriendsViewModel
    @State private var showingInfo: Bool = false
    @State private var showingDeleteAlert: Bool = false
    var friend: Friend
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation {
                        showingInfo.toggle()
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 22, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            gameManager.mainColorSheme(color: .blue)
                        )
                }
                .rotationEffect(Angle(degrees: showingInfo ? 90:0))
                Text("\(friend.name)")
                    .lineLimit(1)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.primary)
                Spacer()
            }
            if showingInfo {
                HStack {
                    VStack {
                        Text("Options")
                            .lineLimit(1)
                            .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.primary)
                    }
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "paperplane")
                            .font(.system(size: 32, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .blue)
                            )
                    }
                    Button {
                        showingDeleteAlert = true
                    } label: {
                        Image(systemName: "trash")
                            .font(.system(size: 32, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .red)
                            )
                    }
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
        .alert("Delete friend?", isPresented: $showingDeleteAlert) {
            Button("OK", role: .destructive) {
                viewModel.removeFriend(friend)
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}

