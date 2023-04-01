//
//  CalendarView.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/03/28.
//

import SwiftUI

struct CalendarView: View {
    @StateObject private var calendarViewModel = CalendarViewModel()
    
    var body: some View {
        VStack {
            CalendarTitleView(calendarViewModel: calendarViewModel)
            CalendarBodyView(calendarViewModel: calendarViewModel)
        }
        .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 14))
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
