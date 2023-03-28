//
//  ComposeView.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/03/28.
//

import SwiftUI

struct ComposeView: View {
    @EnvironmentObject var store: MemoStore
    
    @State private var content: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $content)
                    .padding()
            }
            .navigationTitle("New Memo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement:.navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancle")
                    }
                }
                
                ToolbarItemGroup(placement:.navigationBarTrailing) {
                    Button {
                        store.insert(memo: content)
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
                
            }
        }
    }
}

struct ComposeView_Previews: PreviewProvider {
    static var previews: some View {
        ComposeView()
            .environmentObject(MemoStore())
    }
}
