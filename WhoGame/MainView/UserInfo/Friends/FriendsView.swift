//
//  FriendsView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.02.2022.
//

import SwiftUI

struct FriendsView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @EnvironmentObject var fbManager: FBManager
    @ObservedObject var viewModel: FriendsViewModel = FriendsViewModel()
    @FocusState private var showingKeyboard: Bool
    
    var body: some View {
        ZStack {
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
                            viewModel.showingSearch.toggle()
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 32, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: .green)
                            )
                    }
                    Button {
                        withAnimation {
                            gameManager.showingFriendsView = false
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
                if viewModel.showingSearch {
                    HStack {
                        TextField("Search for User ID", text: $viewModel.userId)
                            .focused($showingKeyboard)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)
                        Spacer()
                        Button {
                            viewModel.userId = ""
                            showingKeyboard = false
                        } label: {
                            Image(systemName: "multiply")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.secondary)
                        }
                        Button {
                            viewModel.search()
                            showingKeyboard = false
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.secondary)
                        }
                        .disabled(viewModel.userId.isEmpty)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 3)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                }
                
                if !viewModel.searchUserName.isEmpty {
                    if !viewModel.hideSearchUser {
                        HStack {
                            Text("\(viewModel.searchUserName)")
                                .lineLimit(1)
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(.primary)
                            Spacer()
                            Group {
                                if viewModel.searchUser.uid == fbManager.uid {
                                    Image(systemName: "theatermasks")
                                        .font(.system(size: 32, weight: .regular))
                                        .symbolVariant(.circle.fill)
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(
                                            Color.white.opacity(0.8),
                                            gameManager.mainColorSheme(color: .red)
                                        )
                                }
                                else if fbManager.friends.filter{ $0.uid == viewModel.searchUser.uid }.count == 0 {
                                    Button {
                                        viewModel.blockAdding = true
                                        viewModel.addFriendRequest()
                                    } label: {
                                        Image(systemName: "plus")
                                            .font(.system(size: 32, weight: .regular))
                                            .symbolVariant(.circle.fill)
                                            .symbolRenderingMode(.palette)
                                            .foregroundStyle(
                                                Color.white.opacity(0.8),
                                                gameManager.mainColorSheme(color: .blue)
                                            )
                                    }
                                    .disabled(viewModel.blockAdding)
                                } else {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 32, weight: .regular))
                                        .symbolVariant(.circle.fill)
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(
                                            Color.white.opacity(0.8),
                                            gameManager.mainColorSheme(color: .green)
                                        )
                                }
                            }
                        }
                        .padding()
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                    }
                }
                
                ScrollView(showsIndicators: false) {
                    ForEach(fbManager.friendRequests) { request in
                        FriendRequestCellView(viewModel: viewModel, request: request)
                    }
                }
                .frame(height: fbManager.friendRequests.isEmpty ? 0:CGFloat(fbManager.friendRequests.count)*80)
                ScrollView(showsIndicators: false) {
                    ForEach(fbManager.friends) { friend in
                        FriendCellView(viewModel: viewModel, friend: friend)
                    }
                    .padding(.bottom, 32)
                }
            }
            .padding()
            if viewModel.showingSendGameView {
                FriendSendGameView(viewModel: viewModel)
                    .transition(.move(edge: .bottom))
                    .animation(.default, value: viewModel.showingSendGameView)
                    .zIndex(1)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(
            RoundedRectangle(cornerRadius: 34)
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        )
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
