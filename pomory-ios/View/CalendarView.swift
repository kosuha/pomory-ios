//
//  CalendarView.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/03/28.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("2023")
                    Text("January")
                }
                Spacer()
            }
            Text("calendar")
            Text("calendar")
            Text("calendar")
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
