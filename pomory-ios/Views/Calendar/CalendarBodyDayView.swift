//
//  DayView.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/04/01.
//

import SwiftUI

struct CalendarBodyDayView: View {
    @ObservedObject var calendarViewModel: CalendarViewModel
    @State private var showingWriteSheet: Bool = false
    @State private var showingReadSheet: Bool = false
    
    @State private var forceRefresh: Bool = false
    
    let dateItem: DateItem
    
    var body: some View {
        VStack {
            if (dateItem.getRecord() != nil)
            {
                if let imageData = dateItem.getRecord()?.image, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 75)
                        .clipped()
                        .cornerRadius(50)
                        
                }
            } else {
                if (isToday(date: dateItem.getDate()) && isSelectedMonth(date: dateItem.getDate(), selectedMonth: calendarViewModel.getSelectedMonth())) {
                    Text("\(dateToString(date: dateItem.getDate(), format: "d"))")
                        .frame(width: 50, height: 75)
                        .font(.system(size: 16, weight: .bold))
                        .cornerRadius(50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(.black, lineWidth: 1.2)
                        )
                } else if (!isToday(date: dateItem.getDate()) && isSelectedMonth(date: dateItem.getDate(), selectedMonth: calendarViewModel.getSelectedMonth()) && isFuture(date: dateItem.getDate())) {
                    Text("\(dateToString(date: dateItem.getDate(), format: "d"))")
                        .frame(width: 50, height: 75)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color(hex: 0x8B95A1))
                        .cornerRadius(50)
                } else if (!isToday(date: dateItem.getDate()) && isSelectedMonth(date: dateItem.getDate(), selectedMonth: calendarViewModel.getSelectedMonth()) && isPast(date: dateItem.getDate())) {
                    Text("\(dateToString(date: dateItem.getDate(), format: "d"))")
                        .frame(width: 50, height: 75)
                        .font(.system(size: 16, weight: .regular))
                        .background(Color(hex: 0x8B95A1).opacity(0.05))
                        .cornerRadius(50)
                }
            }
        }
        
        .onTapGesture {
            if (isToday(date: dateItem.getDate()) || isPast(date: dateItem.getDate())) {
                if (dateItem.getRecord() != nil)
                {
                    showingReadSheet.toggle()
                } else {
                    showingWriteSheet.toggle()
                }
            }
        }
        
        .fullScreenCover(isPresented: $showingWriteSheet, content: {
            CalendarBodyWriteSheetView(
                showingSheet: $showingWriteSheet,
                calendarViewModel: calendarViewModel,
                dateItem: dateItem,
                selectedImage: dateItem.getRecord()?.image,
                title: dateItem.getRecord()?.title,
                text: dateItem.getRecord()?.text,
                stampText: dateItem.getRecord()?.stamp
            )
        })
        
        .fullScreenCover(isPresented: $showingReadSheet, content: {
            CalendarBodyReadSheetView(calendarViewModel: calendarViewModel, showingReadSheet: $showingReadSheet, dateItem: dateItem)
        })
        
        .onReceive(calendarViewModel.$deleteEvent) { _ in
            forceRefresh.toggle()
        }
        
    }
}
