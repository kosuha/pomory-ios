//
//  KeyboardAwareModifier.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/04/03.
//

import Combine
import SwiftUI
import UIKit

class KeyboardHeightPublisher: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0

    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
            .map { $0.height }
            .assign(to: \.keyboardHeight, on: self)
            .store(in: &cancellableSet)

        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
            .assign(to: \.keyboardHeight, on: self)
            .store(in: &cancellableSet)
    }
}
