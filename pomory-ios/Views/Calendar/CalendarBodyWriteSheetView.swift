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
    
    @StateObject private var keyboardHeightPublisher = KeyboardHeightPublisher()
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: Image? = nil
    @State private var selectedUIImage: UIImage? = nil
    
    @State var title: String = ""
    @State var text: String = ""
    @State var stampText: String = ""
    @State var stamp: String = ""
    @FocusState private var isFocusEmojiField: Bool
    @FocusState private var isFocusTextEditor: Bool
    @FocusState private var isFocusTitleField: Bool
    
    let titleMaxLength = 20
    let textMaxLength = 200
    
    
    var body: some View {
        ScrollViewReader { proxy in
            VStack (alignment: .leading, spacing: 0) {
                // top bar
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
                
                ScrollView {
                    // image area
                    
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
                            .id(0)
                            
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
                        
                        
                        // input area
                        VStack {
                            HStack {
                                ZStack() {
                                    EmojiTextField(text: $stampText)
                                        .focused($isFocusEmojiField)
                                        .font(.system(size: 1, weight: .regular))
                                        .background(Color(uiColor: .systemBackground))
                                        .frame(width: 1, height: 1)
                                        .onChange(of: stampText) { value in
                                            if value.count > 1 {
                                                stampText = String(value.suffix(1))
                                            }
                                            stamp = stampText
                                        }
                                    
                                    TextField("제목을 입력해주세요.", text: $title)
                                        .focused($isFocusTitleField)
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.black)
                                        .padding(EdgeInsets(top: 7, leading: 7, bottom: 7, trailing: 7))
                                        .background(Color(uiColor: .systemBackground))
                                        .onChange(of: title) { value in
                                            if value.count > titleMaxLength {
                                                title = String(value.prefix(titleMaxLength))
                                            }
                                        }
                                        .onTapGesture {
                                            withAnimation {
                                                proxy.scrollTo(1, anchor: .top)
                                            }
                                        }
                                        .onSubmit {
                                            withAnimation {
                                                proxy.scrollTo(0, anchor: .top)
                                                hideKeyboard()
                                            }
                                        }
                                }
                                .id(1)
                                
                                ZStack() {
                                    Text(stamp)
                                        .font(.system(size: 35, weight: .bold))
                                        .background(Color(uiColor: .systemBackground))
                                        .frame(width: 35, height: 35)
                                        .onTapGesture {
                                            isFocusEmojiField.toggle()
                                            withAnimation {
                                                proxy.scrollTo(1, anchor: .top)
                                            }
                                        }
                                    
                                    if stampText.isEmpty {
                                        Image(systemName: "plus.circle")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 35, weight: .light))
                                            .onTapGesture {
                                                isFocusEmojiField.toggle()
                                                withAnimation {
                                                    proxy.scrollTo(1, anchor: .top)
                                                }
                                            }
                                    }
                                }
                            }
                            
                            Divider()
                            
                            ZStack(alignment: .topLeading) {
                                TextEditor(text: $text)
                                    .focused($isFocusTextEditor)
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                    .background(Color(uiColor: .systemBackground))
                                    .frame(height: 200)
                                    .onChange(of: text) { value in
                                        if value.count > textMaxLength {
                                            text = String(value.prefix(textMaxLength))
                                        }
                                    }
                                    .onTapGesture {
                                        withAnimation {
                                            proxy.scrollTo(1, anchor: .top)
                                        }
                                    }
                                    .onSubmit {
                                        withAnimation {
                                            proxy.scrollTo(0, anchor: .top)
                                            hideKeyboard()
                                        }
                                    }
                                if text.isEmpty {
                                    Text("남기고 싶은 메모리를 기록해보세요.")
                                        .foregroundColor(.gray)
                                        .padding(EdgeInsets(top: 7, leading: 7, bottom: 7, trailing: 7))
                                        .onTapGesture {
                                            isFocusTextEditor.toggle()
                                            withAnimation {
                                                proxy.scrollTo(1, anchor: .top)
                                            }
                                        }
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
                        
                    }
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 20 + keyboardHeightPublisher.keyboardHeight, trailing: 20))
                    
                }
            }
            .onTapGesture {
                withAnimation {
                    proxy.scrollTo(0, anchor: .top)
                    hideKeyboard()
                }
            }
        }
    }
}
