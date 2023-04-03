//
//  DateViewModel.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/04/03.
//

import SwiftUI

class DateViewModel: ObservableObject {
    @Published private var dateItem: DateItem
    
    init(dateItem: DateItem) {
        self.dateItem = dateItem
    }
    
}
