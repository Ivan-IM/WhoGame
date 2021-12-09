//
//  WhoGameApp.swift
//  WhoGame
//
//  Created by Иван Маришин on 05.12.2021.
//

import SwiftUI

@main
struct WhoGameApp: App {
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
