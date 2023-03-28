//
//  MainListView.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/03/27.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            RecordView()
                .tabItem {
                    Image(systemName: "tray")
                }
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                }
            SettingView()
                .tabItem {
                    Image(systemName: "line.3.horizontal")
                }
        }
        .accentColor(.black)
        .onAppear {
            if #available(iOS 15.0, *) {
                let appearance = UITabBarAppearance()
                UITabBar.appearance().scrollEdgeAppearance = appearance
                UITabBar.appearance().isTranslucent = true
                UITabBar.appearance().backgroundColor = UIColor.white
            }
        }

    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            
    }
}
