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
    
    let dateItem: DateItem
    
    @State private var showingEditSheet: Bool = false
    
    var body: some View {
        
        HStack(alignment: .top) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Image(systemName: "multiply")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(width: 64, height: 64)
                        .onTapGesture {
                            showingReadSheet.toggle()
                        }
                    
                    Spacer()
                    
                    Text("\(dateToString(date: dateItem.getDate(), format: "MMMM d, EEE"))")
                        .font(.system(size: 18, weight: .bold))
                    
                    Spacer()
                    
                    Image(systemName: "ellipsis")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(width: 64, height: 64)
                        .onTapGesture {
                            showingEditSheet.toggle()
                        }
                        .sheet(isPresented: $showingEditSheet) {
                            CalendarBodyReadEditSheetView(calendarViewModel: calendarViewModel, showingEditSheet: $showingEditSheet, showingReadSheet: $showingReadSheet, dateItem: dateItem)
                                .presentationDetents([.height(200)])
                                
                        }
                }
                
                VStack(spacing: 0) {
                    
                    if let imageData = dateItem.getRecord()?.image, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 241.13, height: 322)
                            .clipped()
                            .cornerRadius(20)
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
                    }
                    
                    Text((dateItem.getRecord()?.stamp)!)
                        .font(.system(size: 30))
                        .padding(EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0))
                    
                    VStack(alignment: .center, spacing: 0) {
                        HStack(spacing: 0) {
                            Text((dateItem.getRecord()?.title)!)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .background(Color(uiColor: .systemBackground))
                            
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 22, trailing: 0))

                        HStack(spacing: 0) {
                            Text((dateItem.getRecord()?.text)!)
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 16, weight: .regular))
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .background(Color(uiColor: .systemBackground))
                                .frame(height: 226, alignment: .topLeading)
                            
                            Spacer()
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                
                
            }
        }
        
    }
}
