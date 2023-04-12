//
//  MainListView.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/03/27.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var viewModel: ViewModel
    @State private var selectedIndex = 1
    
    var body: some View {
        ZStack {
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
                .padding(EdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0))
                Spacer()
                Divider()
                HStack{
                    ForEach(0..<Constants.tabBarImagesList.count, id: \.self) { index in
                        if (index != 0) {
                            Spacer()
                        }
                        VStack {
                            Image(systemName: Constants.tabBarImagesList[index])
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
                .padding(EdgeInsets(top: 16, leading: 49, bottom: 16, trailing: 49))
            }
            
            if viewModel.showingReadSheet {
                
            }
            
            if viewModel.showingBottomSheet {
                
            }
            
            if viewModel.showingWriteSheet {
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
