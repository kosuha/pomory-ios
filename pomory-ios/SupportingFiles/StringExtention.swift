//
//  StringExtention.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/04/01.
//

import SwiftUI

extension String {
    func substring(start: Int, end: Int)->String{
        let start = self.index(self.startIndex, offsetBy: start)
        let end = self.index(self.startIndex, offsetBy: end)
        return String(self[start..<end])
    }
}
