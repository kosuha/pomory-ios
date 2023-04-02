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
    @Binding var showingSheet: Bool
    let dateItem: DateItem
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "multiply")
                    .font(.system(size: 18, weight: .semibold))
                    .frame(width: 64, height: 64)
                    .onTapGesture {
                        showingSheet = false
                    }
                
                Spacer()
                
                Text("\(dateToString(date: dateItem.getDate(), format: "MMMM d, EEE"))")
                    .font(.system(size: 18, weight: .bold))
                
                Spacer()
                
                Image(systemName: "multiply")
                    .font(.system(size: 18, weight: .semibold))
                    .frame(width: 64, height: 64)
                    .onTapGesture {
                        showingSheet = false
                    }
            }
            
            VStack {
                
                if let imageData = dateItem.getRecord()?.image, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 268)
                        .clipped()
                        .cornerRadius(20)
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 47, trailing: 0))
                }
                
                Text((dateItem.getRecord()?.title)!)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 7, leading: 7, bottom: 7, trailing: 7))
                    .background(Color(uiColor: .systemBackground))

                Text((dateItem.getRecord()?.text)!)
                    .font(.system(size: 16, weight: .medium))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .background(Color(uiColor: .systemBackground))

            }
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            
            Spacer()
        }
    }
}
