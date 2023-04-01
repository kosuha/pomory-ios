//
//  CalendarBodyView.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/04/01.
//

import SwiftUI

struct CalendarBodyView: View {
    @ObservedObject var calendarViewModel: CalendarViewModel
    
    var body: some View {
        VStack {
            CalendarBodyWeekdaysView()
            
            VStack {
                ForEach(0..<6) { i in
                    HStack {
                        ForEach(0..<7) { j in
                            HStack {
                                Spacer(minLength: 1)
                                CalendarBodyDayView(dateItem: calendarViewModel.getDateItemList()[(i * 7) + j])
                                Spacer(minLength: 1)
                            }
                        }
                    }
                }
            }
            
        }
    }
}
