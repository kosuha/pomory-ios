//
//  Date.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/04/01.
//

import Foundation

class DateItem {
    private let date: Date
    private let selectedMonth: Date
    private let diffFromToday: Int
    
    init(date: Date, selectedMonth: Date) {
        self.date = date
        self.selectedMonth = selectedMonth
        self.diffFromToday = dateCompare(from: Date(), to: date)
    }
    
    func getDate() -> Date {
        return self.date
    }
    
    func getDay() -> String {
        return dateToString(date: self.date, format: "d")
    }
    
    func isToday() -> Bool {
        return (self.diffFromToday == 0)
    }
    
    func isPast() -> Bool {
        return (self.diffFromToday > 0)
    }
    
    func isFuture() -> Bool {
        return (self.diffFromToday < 0)
    }
    
    func getDiff() -> Int {
        return self.diffFromToday
    }
    
    func isSelectedMonth() -> Bool {
        return (dateToString(date: date, format: "yyyyMM") == dateToString(date: selectedMonth, format: "yyyyMM"))
    }
}
