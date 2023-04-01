//
//  util.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/04/01.
//

import SwiftUI

func dateToString(date: Date, format: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: date)
}

func stringToDate(year: String, month: String, day: String) -> Date {
    let dateComponents = DateComponents(year: Int(year), month: Int(month), day: Int(day))
    return Calendar.current.date(from: dateComponents)!
}

func dateCompare(from: Date, to: Date) -> Int {
    let fromString = dateToString(date: from, format: "yyyyMMdd")
    let toString = dateToString(date: to, format: "yyyyMMdd")
    
    let newFrom: Date = stringToDate(year: fromString.substring(start: 0, end: 4), month: fromString.substring(start: 4, end: 6), day: fromString.substring(start: 6, end: 8))
    let newTo: Date = stringToDate(year: toString.substring(start: 0, end: 4), month: toString.substring(start: 4, end: 6), day: toString.substring(start: 6, end: 8))
    return Int(Calendar.current.dateComponents([.minute], from: newFrom, to: newTo).minute!)
}

func getIndexOfFirstWeekday(date: Date) -> Int {
    let firstWeekday : String = dateToString(date: date, format: "EEE")
    
    for index in Constants.weekdayTextList.indices {
        if (firstWeekday == Constants.weekdayTextList[index]) {
            return index
        }
    }
    return 0
}
