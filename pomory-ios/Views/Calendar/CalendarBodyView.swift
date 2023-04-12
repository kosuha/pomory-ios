//
//  CalendarBodyView.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/04/01.
//

import SwiftUI

struct CalendarBodyView: View {
    @ObservedObject var calendarViewModel: CalendarViewModel
    @State private var showingReadSheet = false
    @State private var showingWriteSheet = false
    @State private var showingBottomSheet = false
    
    var body: some View {
        VStack {
            CalendarBodyWeekdaysView()
            
            VStack {
                ForEach(0..<6) { i in
                    HStack {
                        ForEach(0..<7) { j in
                            HStack {
                                Spacer(minLength: 1)
                                CalendarBodyDayView(calendarViewModel: calendarViewModel, dateItem: calendarViewModel.getDateItemList()[i * 7 + j])
                                .onTapGesture {
                                    if (isToday(date: calendarViewModel.getDateItemList()[i * 7 + j].getDate()) || isPast(date: calendarViewModel.getDateItemList()[i * 7 + j].getDate())) {
                                        if (calendarViewModel.getDateItemList()[i * 7 + j].getRecord() != nil)
                                        {
                                            calendarViewModel.setRecordCopy(dateItem: calendarViewModel.getDateItemList()[i * 7 + j])
                                            showingReadSheet.toggle()
                                        } else {
                                            showingWriteSheet.toggle()
                                        }
                                    }
                                }
                            }
                            Spacer(minLength: 1)
                        }
                    }
                }
            }
        }
        
    }
}
