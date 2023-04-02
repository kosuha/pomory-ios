//
//  CalendarBodyWriteSheetView.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/04/02.
//

import SwiftUI
import PhotosUI
import CoreData

struct CalendarBodyWriteSheetView: View {
    @Binding var showingSheet: Bool
    @ObservedObject var calendarViewModel: CalendarViewModel
    let dateItem: DateItem
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: Image? = nil
    @State private var selectedUIImage: UIImage? = nil

    @State var title: String = ""
    @State var text: String = ""
    @State var stamp: String = ""
    
    let titleMaxLength = 20
    let textMaxLength = 200
    
    
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
                
                if (title.isEmpty || text.isEmpty || selectedImage == nil) {
                    Image(systemName: "checkmark")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.gray)
                        .frame(width: 64, height: 64)
                } else {
                    Image(systemName: "checkmark")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(width: 64, height: 64)
                        .onTapGesture {
                            showingSheet = false
                            // upload action
                            calendarViewModel.saveData(date: dateItem.getDate(), title: title, stamp: stamp, text: text, selectedUIImage: selectedUIImage!)
                            calendarViewModel.setDateItem(dateItem: dateItem)
                        }
                }
            }
            
            VStack {
                
                if let image = selectedImage {
                    ZStack(alignment: .topTrailing) {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 268)
                            .clipped()
                            .cornerRadius(20)
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 47, trailing: 0))
                        Circle()
                            .fill(Color(hex: 0x191F28, alpha: 0.7))
                            .frame(width: 26, height: 26)
                            .overlay(
                                Image(systemName: "multiply")
                                    .font(.system(size: 18, weight: .regular))
                                    .foregroundColor(.white)
                            )
                            .padding(15)
                            .onTapGesture {
                                selectedImage = nil
                            }
                    }
                    
                } else {
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(hex: 0xF2F2F2))
                            .frame(width: 200, height: 268)
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(.black, lineWidth: 1)
                                    .frame(width: 48, height: 74)
                            )
                            .overlay(
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                                    .font(.system(size: 24, weight: .regular))
                            )
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 47, trailing: 0))
                    }
                    .onChange(of: selectedItem) { newValue in
                        Task {
                            if let imageData = try? await newValue?.loadTransferable(type: Data.self), let image = UIImage(data: imageData) {
                                selectedImage = Image(uiImage: image)
                                selectedUIImage = image
                            }
                        }
                    }
                }
                
                
                HStack {
                    TextField("제목을 입력해주세요.", text: $title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 7, leading: 7, bottom: 7, trailing: 7))
                        .background(Color(uiColor: .systemBackground))
                        .onChange(of: title) { value in
                            if value.count > titleMaxLength {
                                title = String(value.prefix(titleMaxLength))
                            }
                        }
                    Image(systemName: "plus.circle")
                        .foregroundColor(.gray)
                        .font(.system(size: 35, weight: .light))
                }
                
                Divider()
                
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $text)
                        .font(.system(size: 16, weight: .medium))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .background(Color(uiColor: .systemBackground))
                        .onChange(of: text) { value in
                            if value.count > textMaxLength {
                                text = String(value.prefix(textMaxLength))
                            }
                        }
                    if text.isEmpty {
                        Text("남기고 싶은 메모리를 기록해보세요.")
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 7, leading: 7, bottom: 7, trailing: 7))
                    }
                }
                
                
                
                HStack {
                    Spacer()
                    Text("\(text.count)/\(textMaxLength)")
                        .font(.system(size: 12, weight: .light))
                        .foregroundColor(.gray)
                }
                Divider()
            }
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            
            Spacer()
        }
    }
    
    
}
