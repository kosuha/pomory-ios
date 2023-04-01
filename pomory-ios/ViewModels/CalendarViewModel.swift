//
//  ViewModel.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/04/01.
//

import SwiftUI

class CalendarViewModel: ObservableObject {
    @Published private var selectedMonth: Date = Date()
    
    private var dateItemList: Array<DateItem>
    
    init() {
        let yearString = dateToString(date: Date(), format: "yyyy")
        let monthString = dateToString(date: Date(), format: "MM")
        let _selectedMonth: Date = stringToDate(year: yearString, month: monthString, day: "01")
        self.selectedMonth = _selectedMonth
        self.dateItemList = []
        let dateIndex : Int = 1 - getIndexOfFirstWeekday(date: _selectedMonth)
        for i in 0..<6 {
            for j in 1..<8 {
                let date : Date = stringToDate(year: yearString, month: monthString, day: String(dateIndex + (i * 7) + j - 1))
                let dateItem: DateItem = DateItem(date: date, selectedMonth: _selectedMonth)
                self.dateItemList.append(dateItem)
            }
        }
    }
    
    func getSelectedMonth() -> Date {
        return self.selectedMonth
    }
    
    func setSelectedMonth(year: String, month: String) {
        self.selectedMonth = stringToDate(year: year, month: month, day: "01")
    }
    
    func getDateItemList() -> Array<DateItem> {
        return self.dateItemList
    }
}
