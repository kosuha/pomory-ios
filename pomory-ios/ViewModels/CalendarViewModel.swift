//
//  ViewModel.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/04/01.
//

import SwiftUI
import CoreData
import PhotosUI

class CalendarViewModel: ObservableObject {
    @Published private var selectedMonth: Date = Date()
    @Published private var dateItemList: Array<DateItem>
    
    private var viewContext: NSManagedObjectContext
    
    
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        let yearString = dateToString(date: Date(), format: "yyyy")
        let monthString = dateToString(date: Date(), format: "MM")
        let _selectedMonth: Date = stringToDate(year: yearString, month: monthString, day: "01")
        self.selectedMonth = _selectedMonth
        self.dateItemList = []
        setSelectedMonth(year: yearString, month: monthString)
        
    }
    
    func getSelectedMonth() -> Date {
        return self.selectedMonth
    }
    
    // fetch
    private func fetchRecords(year: String, month: String) {
        let calendar = Calendar.current
        let startDate = calendar.date(from: DateComponents(year: calendar.component(.year, from: selectedMonth), month: calendar.component(.month, from: selectedMonth), day: 1))!
        let endDate = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDate)!
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
        fetchRequest.predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", startDate as NSDate, endDate as NSDate)
        
        do {
            let records = try viewContext.fetch(fetchRequest) as! [Record]
            let dateIndex : Int = 1 - getIndexOfFirstWeekday(date: self.selectedMonth)
            // fetchedEvents로 할 작업들
            self.dateItemList.removeAll()
            for i in 0..<6 {
                for j in 0..<7 {
                    let date : Date = stringToDate(year: year, month: month, day: String(dateIndex + (i * 7) + j))
                    var tmp: Record? = nil
                    for k in records {
                        if (k.date == date) {
                            tmp = k
                            break
                        }
                    }
                    let dateItem = DateItem(index: (i * 7) + j ,date: date, record: tmp)
                    self.dateItemList.append(dateItem)
                }
            }
        } catch {
            print("Error fetching events: \(error)")
        }
    }
//
//    private func fetchRecord(date: Date) {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
//        fetchRequest.predicate = NSPredicate(format: "(date == %@)", date as NSDate)
//
//        do {
//            let records = try viewContext.fetch(fetchRequest) as! [Record]
//
//            // fetchedEvents로 할 작업들
//
//
//
//
//
//        } catch {
//            print("Error fetching events: \(error)")
//        }
//    }
    
    func setSelectedMonth(year: String, month: String) {
        self.selectedMonth = stringToDate(year: year, month: month, day: "01")
        self.fetchRecords(year: year, month: month)
    }
    
    func setDateItem(dateItem: DateItem) {        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
        fetchRequest.predicate = NSPredicate(format: "(date == %@)", dateItem.getDate() as NSDate)
        
        do {
            let records = try viewContext.fetch(fetchRequest) as! [Record]
            let newDateItem = DateItem(index: dateItem.getIndex(), date: dateItem.getDate(), record: records[0])
            self.dateItemList.remove(at: newDateItem.getIndex())
            self.dateItemList.insert(newDateItem, at: newDateItem.getIndex())
        } catch {
            print("Error fetching events: \(error)")
        }
    }
    
    func getDateItemList() -> Array<DateItem> {
        return self.dateItemList
    }
    
    func saveRecord(date: Date, title: String, stamp: String?, text: String, selectedUIImage: UIImage) {
        let context = PersistenceController.shared.container.viewContext
        let newRecord = Record(context: context)

        newRecord.title = title
        newRecord.stamp = stamp
        newRecord.text = text
        newRecord.date = date
        newRecord.image = selectedUIImage.jpegData(compressionQuality: 0.8)
        
        do {
            try context.save()
        } catch {
            print("Error saving record: \(error)")
        }
    }
    
    func deleteRecord(dateItem: DateItem) {
        let context = PersistenceController.shared.container.viewContext
        
        context.delete(dateItem.getRecord()!)
//        self.dateItemList.remove(at: dateItem.getIndex())
        
        do {
            try context.save()
        } catch {
            print("Error delete record: \(error)")
        }
    }
    
    func deleteRecordAtMemory(dateItem: DateItem) {
        self.dateItemList.remove(at: dateItem.getIndex())
    }
}
