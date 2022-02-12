//
//  FriendSendGameView.swift
//  WhoGame
//
//  Created by Иван Маришин on 12.02.2022.
//

import SwiftUI

struct FriendSendGameView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @ObservedObject var viewModel: FriendsViewModel
    @FocusState private var showingKeyboard: Bool
    @State var isFavorite: Bool = false
    @State var showingSearch: Bool = false
    @State var searchText: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Games")
                        .lineLimit(1)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(
                            gameManager.mainColorSheme(color: .green)
                        )
                    Spacer()
                    Button {
                        withAnimation {
                            showingSearch.toggle()
                        }
                        searchText = ""
                        showingKeyboard = false
                        isFavorite = false
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
                            viewModel.showingSendGameView = false
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
                if showingSearch {
                    HStack {
                        TextField("Game name", text: $searchText)
                            .focused($showingKeyboard)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.secondary)
                        Spacer()
                        Button {
                            searchText = ""
                            showingKeyboard = false
                        } label: {
                            Image(systemName: "multiply")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.secondary)
                        }
                        Button {
                            showingKeyboard = false
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.secondary)
                        }
                        Button {
                            isFavorite.toggle()
                            showingKeyboard = false
                        } label: {
                            Image(systemName: "star")
                                .font(.system(size: 16, weight: .regular))
                                .symbolVariant(isFavorite ? .fill:.none)
                                .foregroundColor(isFavorite ? .yellow:.secondary)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 3)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                }
                FriendSendGameListView(searchText: searchText, isFavorite: isFavorite, showingSearch: showingSearch, viewModel: viewModel)
            }
            .padding()
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
            .background(
                RoundedRectangle(cornerRadius: 34)
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
            )
        }
    }
}
