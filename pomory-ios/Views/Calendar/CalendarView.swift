//
//  CalendarView.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/03/28.
//

import SwiftUI

struct CalendarView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var calendarViewModel: CalendarViewModel
    
    init() {
        let context = PersistenceController.shared.container.viewContext
        _calendarViewModel = StateObject(wrappedValue: CalendarViewModel(viewContext: context))
    }

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
