//
//  PlayGameView.swift
//  WhoGame
//
//  Created by Иван Маришин on 08.01.2022.
//

import SwiftUI

struct PlayGameView: View {
    
    @FetchRequest(entity: GameCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GameCD.date, ascending: false)]) var games: FetchedResults<GameCD>
    
    var body: some View {
        List {
            ForEach(games) { game in
                Button {
                    
                } label: {
                    VStack(alignment: .leading, spacing: 3) {
                        Text(game.name ?? "Unknown")
                            .font(.headline)
                        if !(game.theme?.isEmpty ?? false) {
                            Text("Theme: \(game.theme ?? "Unknown")")
                                .font(.subheadline)
                        }
                        Text("Questions: \(PersistenceController.shared.fetchGameCards(for: game.id ?? "").count)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .foregroundColor(.primary)
                }
            }
        }
        .navigationTitle("Games")
    }
}

struct PlayGameView_Previews: PreviewProvider {
    static var previews: some View {
        PlayGameView()
    }
}
