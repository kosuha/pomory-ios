//
//  CalendarBodyReadEditSheetView.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/04/05.
//

import SwiftUI

struct CalendarBodyReadBottomSheetView: View {
    @ObservedObject var calendarViewModel: CalendarViewModel
    @Binding var showingBottomSheet: Bool
    @Binding var showingReadSheet: Bool
    
    let dateItem: DateItem
    
    @State var showingEditSheet: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 100)
                .fill(Color(hex: 0xEAE8EB))
                .frame(width: 60, height: 5)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 32, trailing: 0))
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Image(systemName: "pencil")
                    Text("수정하기")
                }
                .frame(width: 350, height: 56)
                .overlay(
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(.black, lineWidth: 1)
                )
                .padding(.bottom, 12)
                .onTapGesture {
                    showingReadSheet.toggle()
                    showingBottomSheet.toggle()
                }
                .fullScreenCover(isPresented: $showingEditSheet, content: {
                    CalendarBodyWriteSheetView(
                        calendarViewModel: calendarViewModel,
                        showingReadSheet: $showingReadSheet,
                        dateItem: dateItem,
                        selectedImage: dateItem.getRecord()?.image,
                        title: dateItem.getRecord().title,
                        text: dateItem.getRecord()?.text,
                        stamp: dateItem.getRecord()?.stamp
                    )
                })
                
                HStack(spacing: 0) {
                    Image(systemName: "trash.fill")
                    Text("삭제하기")
                }
                .frame(width: 350, height: 56)
                .overlay(
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(.black, lineWidth: 1)
                )
                .onTapGesture {
                    showingReadSheet.toggle()
                    showingBottomSheet.toggle()
                    calendarViewModel.deleteRecord(dateItem: dateItem)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))

            
            Spacer()
        }
    }
}