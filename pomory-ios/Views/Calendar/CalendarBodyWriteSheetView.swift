//
//  CalendarBodyWriteSheetView.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/04/02.
//

import SwiftUI
import PhotosUI
import CoreData
import Introspect

struct CalendarBodyWriteSheetView: View {
    @Binding var showingWriteSheet: Bool
    @Binding var showingBottomSheet: Bool
    @ObservedObject var calendarViewModel: CalendarViewModel
    let dateItem: DateItem
    
    
    @StateObject private var keyboardHeightPublisher = KeyboardHeightPublisher()
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedUIImage: UIImage?
    @State private var selectedImage: Image?
    @State private var title: String
    @State private var text: String
    @State private var stampText: String
    
    @State private var stamp: String
    private let isEdit: Bool
    @State private var textPlaceholder = "남기고 싶은 기억을 기록해보세요."
    
    @FocusState private var isFocusEmojiField: Bool
    @FocusState private var isFocusTextEditor: Bool
    @FocusState private var isFocusTextPlaceholder: Bool
    @FocusState private var isFocusTitleField: Bool
    
    let titleMaxLength = 20
    let textMaxLength = 200
    
    init(showingWriteSheet: Binding<Bool>, showingBottomSheet: Binding<Bool>, calendarViewModel: CalendarViewModel, dateItem: DateItem) {
        self._showingWriteSheet = showingWriteSheet
        self._showingBottomSheet = showingBottomSheet
        self.calendarViewModel = calendarViewModel
        self.dateItem = dateItem
        self._title = State(initialValue: dateItem.getRecord()?.title ?? "")
        self._text = State(initialValue: dateItem.getRecord()?.text ?? "")
        self._stampText = State(initialValue: dateItem.getRecord()?.stamp ?? "")
        self._stamp = State(initialValue: dateItem.getRecord()?.stamp ?? "")
        
        if let imageData = dateItem.getRecord()?.image, let uiImage = UIImage(data: imageData) {
            self._selectedImage = State(initialValue: Image(uiImage: uiImage))
            self._selectedUIImage = State(initialValue: uiImage)
            self.isEdit = true
        } else {
            self._selectedImage = State(initialValue: nil)
            self._selectedUIImage = State(initialValue: nil)
            self.isEdit = false
        }
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            HStack(alignment: .top, spacing: 0) {
                VStack(spacing: 0) {
                    // top bar
                    HStack(spacing: 0) {
                        Image(systemName: "multiply")
                            .font(.system(size: 18, weight: .semibold))
                            .frame(width: 64, height: 64)
                            .onTapGesture {
                                showingWriteSheet = false
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
//                                    showingWriteSheet = false
                                    // upload action
                                    if (!isEdit) {
                                        showingWriteSheet = false
                                        calendarViewModel.saveRecord(date: dateItem.getDate(), title: title, stamp: stamp, text: text, selectedUIImage: selectedUIImage!)
                                        calendarViewModel.setDateItem(dateItem: dateItem)
                                    } else {
//                                        showingBottomSheet = false
                                        showingWriteSheet = false
                                        calendarViewModel.deleteRecord(dateItem: dateItem)
                                        calendarViewModel.saveRecord(date: dateItem.getDate(), title: title, stamp: stamp, text: text, selectedUIImage: selectedUIImage!)
                                        calendarViewModel.setDateItem(dateItem: dateItem)
                                    }
                                    
                                }
                        }
                    }
                    
                    ScrollView {
                        // image area
                        
                        VStack(spacing: 0) {
                            VStack(spacing: 0) {
                                if let image = selectedImage {
                                    ZStack(alignment: .topTrailing) {
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 241.13, height: 322)
                                            .clipped()
                                            .cornerRadius(20)
                                            .foregroundColor(.gray)
                                        
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
                                                selectedUIImage = nil
                                                selectedItem = nil
                                            }
                                    }
                                    
                                } else {
                                    PhotosPicker(selection: $selectedItem, matching: .images) {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color(hex: 0xF2F2F2))
                                            .frame(width: 241.13, height: 322)
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
                                        
                                    }
                                    .onChange(of: selectedItem) { newValue in
                                        Task {
                                            if let imageData = try? await newValue?.loadTransferable(type: Data.self), let uiImage = UIImage(data: imageData) {
                                                selectedImage = Image(uiImage: uiImage)
                                                selectedUIImage = uiImage
                                            }
                                        }
                                    }
                                    
                                }
                            }
                            .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
                            .id(0)
                            
                            // input area
                            VStack(spacing: 0) {
                                
                                // stamp display
                                ZStack {
                                    Text(stamp)
                                        .font(.system(size: 35))
                                        .background(Color(uiColor: .systemBackground))
                                        .frame(width: 54, height: 54)
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
                                            .frame(width: 54, height: 54)
                                            .onTapGesture {
                                                isFocusEmojiField.toggle()
                                                withAnimation {
                                                    proxy.scrollTo(1, anchor: .top)
                                                }
                                            }
                                    }
                                }
                                .padding(10)
                                
                                // title input
                                ZStack {
                                    EmojiTextField(text: $stampText)
                                        .focused($isFocusEmojiField)
                                        .font(.system(size: 1, weight: .regular))
                                        .background(Color(uiColor: .systemBackground))
                                        .frame(width: 1, height: 1)
                                        .onChange(of: stampText) { value in
                                            Vibration.selection.vibrate()
                                            if value.count > 1 {
                                                stampText = String(value.suffix(1))
                                            }
                                            stamp = stampText
                                            hideKeyboard()
                                            proxy.scrollTo(0, anchor: .top)
                                        }
                                    
                                    TextField("제목을 입력해주세요.", text: $title)
                                        .focused($isFocusTitleField)
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.black)
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
                                                hideKeyboard()
                                                proxy.scrollTo(0, anchor: .top)
                                            }
                                        }
                                }
                                .padding(.bottom, 22)
                                
                                // text input
                                ZStack(alignment: .topLeading) {
                                    if (text.isEmpty) {
                                        TextEditor(text: $textPlaceholder)
                                            .padding(0)
                                            .introspectTextView { textView in
                                                textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                                                textView.textContainer.lineFragmentPadding = 0
                                            }
                                            .padding(0)
                                            .focused($isFocusTextEditor)
                                            .font(.system(size: 16, weight: .regular))
                                            .background(Color(uiColor: .systemBackground))
                                            .frame(height: 226)
                                            .onTapGesture {
                                                withAnimation {
                                                    proxy.scrollTo(1, anchor: .top)
                                                }
                                            }
                                            .padding(0)
                                        
                                    }
                                        
                                    TextEditor(text: $text)
                                        .introspectTextView { textView in
                                            textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                                            textView.textContainer.lineFragmentPadding = 0
                                        }
                                        .focused($isFocusTextEditor)
                                        .font(.system(size: 16, weight: .regular))
                                        .background(Color(uiColor: .systemBackground))
                                        .frame(height: 226)
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
                                        .scrollDismissesKeyboard(.never)
                                        .padding(0)
                                    
                                    if text.isEmpty {
                                        Text("남기고 싶은 메모리를 기록해보세요.")
                                            .font(.system(size: 16, weight: .regular))
                                            .foregroundColor(.gray)
                                            .padding(7)
                                            .onTapGesture {
                                                isFocusTextEditor.toggle()
                                                withAnimation {
                                                    proxy.scrollTo(1, anchor: .top)
                                                }
                                            }
                                    }
                                }
                                
//                                // 글자수세기
//                                HStack(spacing: 0) {
//                                    Spacer()
//                                    Text("\(text.count)/\(textMaxLength)")
//                                        .font(.system(size: 12, weight: .light))
//                                        .foregroundColor(.gray)
//                                        .padding(3)
//                                }
                            }
                            .id(1)
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0 + keyboardHeightPublisher.keyboardHeight, trailing: 20))
                    }
                    .scrollDismissesKeyboard(.immediately)
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
}
