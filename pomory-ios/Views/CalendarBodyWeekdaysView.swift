//
//  CalendarBodyWeekdaysView.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/04/01.
//

import SwiftUI

struct CalendarBodyWeekdaysView: View {
    var body: some View {        
        HStack {
            ForEach(Constants.weekdayTextListUppercase, id: \.self) { weekday in
                HStack {
                    Spacer(minLength: 1)
                    Text(weekday)
                        .font(.system(size: 12))
                    Spacer(minLength: 1)
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 28, trailing: 0))
    }
}

struct CalendarBodyWeekdaysView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarBodyWeekdaysView()
    }
}
