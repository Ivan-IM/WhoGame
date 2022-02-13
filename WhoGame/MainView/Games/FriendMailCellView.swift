//
//  FriendMailCellView.swift
//  WhoGame
//
//  Created by Иван Маришин on 10.02.2022.
//

import SwiftUI

struct FriendMailCellView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @ObservedObject var viewModel: FriendMailViewModel
    @State var sendGame: Bool = false
    let friend: Friend
    
    var body: some View {
        HStack {
            Text("\(friend.name)")
                .lineLimit(1)
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.primary)
            Spacer()
            Button {
                viewModel.sendGame(friend: friend)
                sendGame = true
            } label: {
                Image(systemName: sendGame ? "checkmark":"paperplane")
                    .font(.system(size: 32, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        gameManager.mainColorSheme(color: sendGame ? .green:.blue)
                    )
            }
            .disabled(sendGame)
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
    }
}