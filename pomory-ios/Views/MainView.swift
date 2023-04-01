//
//  MainListView.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/03/27.
//

import SwiftUI

struct MainView: View {
    @State private var selectedIndex = 1
    
    var body: some View {
        VStack {
            ZStack {
                switch selectedIndex {
                case 0:
                    RecordView()
                case 1:
                    CalendarView()
                case 2:
                    SettingView()
                default:
                    CalendarView()
                }
            }
            Spacer()
            Divider()
            HStack{
                ForEach(0..<Constants.tabBarImages.count, id: \.self) { index in
                    if (index != 0) {
                        Spacer()
                    }
                    VStack {
                        Image(systemName: Constants.tabBarImages[index])
                            .font(.system(size: 26))
                            .foregroundColor(selectedIndex == index ? Color(.black) : Color(.tertiaryLabel))
                    }
                    .gesture(
                        TapGesture()
                            .onEnded { _ in
                                selectedIndex = index
                            }
                    )
                }
            }
            .padding([.leading, .trailing], 49)
            .padding([.top, .bottom], 16)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
