//
//  DayView.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/04/01.
//

import SwiftUI

struct CalendarBodyDayView: View {
    var dateItem: DateItem
    
    var body: some View {
        if (dateItem.isToday() && dateItem.isSelectedMonth()) {
            Text("\(dateItem.getDay())")
                .frame(width: 50, height: 75)
                .font(.system(size: 16, weight: .bold))
                .background(Color(hex: 0x8B95A1).opacity(0.05))
                .cornerRadius(50)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(.black, lineWidth: 1.2)
                )
        } else if (!dateItem.isToday() && dateItem.isSelectedMonth() && dateItem.isPast()) {
            Text("\(dateItem.getDay())")
                .frame(width: 50, height: 75)
                .font(.system(size: 16))
                .foregroundColor(Color(hex: 0x8B95A1))
                .cornerRadius(50)
        } else if (!dateItem.isToday() && dateItem.isSelectedMonth() && dateItem.isFuture()) {
            Text("\(dateItem.getDay())")
                .frame(width: 50, height: 75)
                .font(.system(size: 16))
                .background(Color(hex: 0x8B95A1).opacity(0.05))
                .cornerRadius(50)
        }
    }
}
