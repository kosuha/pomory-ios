//
//  pomory_iosApp.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/03/27.
//

import SwiftUI

@main
struct pomory_iosApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
