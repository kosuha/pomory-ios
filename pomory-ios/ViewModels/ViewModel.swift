//
//  ViewModel.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/04/12.
//

import SwiftUI
import CoreData
import Combine

class ViewModel: ObservableObject {
    private var viewContext: NSManagedObjectContext
    
    @Published var showingReadSheet: Bool
    @Published var showingWriteSheet: Bool
    @Published var showingBottomSheet: Bool
    
    @Published var selectedMonth: Date
    @Published var recordList: Array<Record>
    @Published var recordCopy: RecordCopy?
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        
        self.showingReadSheet = false
        self.showingWriteSheet = false
        self.showingBottomSheet = false
        
        self.selectedMonth = stringToDate(year: dateToString(date: Date(), format: "yyyy"), month: dateToString(date: Date(), format: "MM"), day: "01")
        self.recordList = []
        self.recordCopy = nil
    }
    
    private func fetchAllRecords() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
        
        do {
            let records = try viewContext.fetch(fetchRequest) as! [Record]
            
            // fetchedEvents로 할 작업들
            // 필요한 작업을 추가하십시오.
            for record in records {
                print("Record date: \(String(describing: record.date))")
                // ... 다른 작업들
            }
            
        } catch {
            print("Error fetching events: \(error)")
        }
    }
    
//    private func fetchRecords(year: String, month: String) {
//        let calendar = Calendar.current
//        let startDate = calendar.date(from: DateComponents(year: calendar.component(.year, from: selectedMonth), month: calendar.component(.month, from: selectedMonth), day: 1))!
//        let endDate = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDate)!
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
//        fetchRequest.predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", startDate as NSDate, endDate as NSDate)
//
//        do {
//            let records = try viewContext.fetch(fetchRequest) as! [Record]
//            let dateIndex : Int = 1 - getIndexOfFirstWeekday(date: self.selectedMonth)
//            // fetchedEvents로 할 작업들
//            for i in 0..<6 {
//                for j in 0..<7 {
//                    let date : Date = stringToDate(year: year, month: month, day: String(dateIndex + (i * 7) + j))
//                    var tmp: Record? = nil
//                    for k in records {
//                        if (k.date == date) {
//                            tmp = k
//                            break
//                        }
//                    }
//                    let dateItem = DateItem(index: (i * 7) + j ,date: date, record: tmp)
//                    self.recordList.append(dateItem)
//                }
//            }
//        } catch {
//            print("Error fetching events: \(error)")
//        }
//    }
}

