//
//  Date.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/04/01.
//

import Foundation

class DateItem {
    private let index: Int
    private let date: Date
    private let record: Record?
    
    init(index: Int, date: Date, record: Record? = nil) {
        self.index = index
        self.date = date
        self.record = record
    }
    
    func getIndex() -> Int {
        return self.index
    }
    
    func getDate() -> Date {
        return self.date
    }

    func getRecord() -> Record? {
        return self.record
    }
}
