//
//  EnvironmentValues.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/04/06.
//

import SwiftUI

// 공유 Presentation 상태를 위한 Environment 키 생성
struct PresentationStatusKey: EnvironmentKey {
    static let defaultValue: Binding<Bool>? = nil
}

extension EnvironmentValues {
    var presentationStatus: Binding<Bool>? {
        get { self[PresentationStatusKey.self] }
        set { self[PresentationStatusKey.self] = newValue }
    }
}
