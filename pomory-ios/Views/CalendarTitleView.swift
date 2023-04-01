//
//  CalendarTitleView.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/04/01.
//

import SwiftUI

struct CalendarTitleView: View {
    @ObservedObject var calendarViewModel: CalendarViewModel
    
    var body: some View {
        let year : String = dateToString(date: calendarViewModel.getSelectedMonth(), format: "yyyy")
        let monthText : String = dateToString(date: calendarViewModel.getSelectedMonth(), format: "MMMM")
        
        HStack {
            VStack (alignment: .leading, spacing: 0) {
                Text("\(year)")
                    .font(.system(size: 18, weight: .bold))
                HStack {
                    Text("\(monthText)")
                        .font(.system(size: 30, weight: .bold))
                    Image(systemName: "calendar")
                        .font(.system(size: 20))
                        .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
                }
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 6, bottom: 20, trailing: 6))
    }
}
