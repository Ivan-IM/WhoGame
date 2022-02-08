//
//  FriendRequestCellView.swift
//  WhoGame
//
//  Created by Иван Маришин on 08.02.2022.
//

import SwiftUI

struct FriendRequestCellView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @ObservedObject var viewModel: FriendsViewModel
    var request: FriendRequest
    
    var body: some View {
        HStack {
            Text("\(request.sendName)")
                .lineLimit(1)
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.primary)
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "checkmark")
                    .font(.system(size: 32, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        gameManager.mainColorSheme(color: .green)
                    )
            }
            Button {
                
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 32, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        gameManager.mainColorSheme(color: .red)
                    )
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
    }
}

