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
                VStack (alignment: .leading, spacing: 0) {
                    Text("2023")
                    Text("January")
                }
                Spacer()
            }
            .border(.green)
            Text("calendar")
                .padding(EdgeInsets(top: 100, leading: 100, bottom: 100, trailing: 100))
                .border(.green)
        }
        .border(.red)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
