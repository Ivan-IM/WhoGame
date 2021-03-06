//
//  GameListView.swift
//  WhoGame
//
//  Created by Иван Маришин on 08.01.2022.
//

import SwiftUI

struct GameListView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @Environment(\.presentationMode) var presentationMode
    @FocusState private var showingKeyboard: Bool
    @State var doYouWantToPlay: Bool = true
    @State var isFavorite: Bool = false
    @State var showingSearch: Bool = false
    @State var searchText: String = ""
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                HStack {
                    Group {
                        if doYouWantToPlay {
                            Text("Play")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundStyle(
                                    gameManager.mainColorSheme(color: .blue)
                                )
                        } else {
                            Text("Edit")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundStyle(
                                    gameManager.mainColorSheme(color: .red)
                                )
                        }
                    }
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
                        doYouWantToPlay.toggle()
                        showingKeyboard = false
                    } label: {
                        if doYouWantToPlay {
                            Image(systemName: "line.3.horizontal")
                                .font(.system(size: 32, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    gameManager.mainColorSheme(color: .red)
                                )
                        } else {
                            Image(systemName: "play")
                                .font(.system(size: 32, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    gameManager.mainColorSheme(color: .blue)
                                )
                        }
                    }
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "multiply")
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
                FilterListView(searchText: searchText, doYouWantToPlay: doYouWantToPlay, isFavorite: isFavorite, showingSearch: showingSearch)
            }
            .navigationBarHidden(true)
            .padding()
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView()
    }
}
