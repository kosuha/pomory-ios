//
//  pomory_iosApp.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/03/27.
//

import SwiftUI

@main
struct pomory_iosApp: App {
    @StateObject var store = MemoStore()
    
    var body: some Scene {
        WindowGroup {
            MainListView()
                .environmentObject(store)
        }
    }
}
