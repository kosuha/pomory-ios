//
//  CalendarBodyReadSheetView.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/04/02.
//

import SwiftUI
import PhotosUI
import CoreData

struct CalendarBodyReadSheetView: View {
    @ObservedObject var calendarViewModel: CalendarViewModel
    @Binding var showingReadSheet: Bool
    @Binding var showingWriteSheet: Bool
    @State private var showingBottomSheet: Bool = false
//    @State private var showingBottomSheet: Bool = false
    let dateItem: DateItem
    
    var body: some View {
        
        if let title = calendarViewModel.getRecordCopy()?.title,
           let date = calendarViewModel.getRecordCopy()?.date,
           let text = calendarViewModel.getRecordCopy()?.text,
           let stamp = calendarViewModel.getRecordCopy()?.stamp,
           let imageData = calendarViewModel.getRecordCopy()?.image,
           let uiImage = UIImage(data: imageData)
        {
            HStack(alignment: .top, spacing: 0) {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Image(systemName: "multiply")
                            .font(.system(size: 18, weight: .semibold))
                            .frame(width: 64, height: 64)
                            .onTapGesture {
                                showingReadSheet.toggle()
                            }
                        
                        Spacer()
                        
                        Text("\(dateToString(date: date, format: "MMMM d, EEE"))")
                            .font(.system(size: 18, weight: .bold))
                        
                        Spacer()
                        
                        Image(systemName: "ellipsis")
                            .font(.system(size: 18, weight: .semibold))
                            .frame(width: 64, height: 64)
                            .onTapGesture {
                                showingBottomSheet.toggle()
                            }
                            .sheet(isPresented: $showingBottomSheet) {
                                CalendarBodyReadBottomSheetView(
                                    calendarViewModel: calendarViewModel,
                                    showingBottomSheet: $showingBottomSheet,
                                    showingReadSheet: $showingReadSheet,
//                                    showingWriteSheet: $showingWriteSheet,
                                    dateItem: dateItem
                                )
                                .presentationDetents([.height(200)])
                            }
                    }
                    
                    VStack(spacing: 0) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 241.13, height: 322)
                            .clipped()
                            .cornerRadius(20)
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
                        
                        Text(stamp)
                            .font(.system(size: 35))
                            .frame(width: 54, height: 54)
                            .padding(10)

                        VStack(alignment: .center, spacing: 0) {
                            HStack(spacing: 0) {
                                
                                Text(title)
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                    .background(Color(uiColor: .systemBackground))
                                
                                Spacer()
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 22, trailing: 0))

                            VStack {
                                ScrollView {
                                    Text(text)
                                        .multilineTextAlignment(.leading)
                                        .font(.system(size: 16, weight: .regular))
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                        .background(Color(uiColor: .systemBackground))
                                        .frame(minWidth: UIScreen.main.bounds.width - 40, alignment: .topLeading)
                                }
                                .frame(maxHeight: 226)
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                }
            }
        } else {
            EmptyView()
            
        }
    }
}
