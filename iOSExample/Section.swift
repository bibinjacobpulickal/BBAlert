//
//  Section.swift
//  iOSExample
//
//  Created by Bibin Jacob Pulickal on 15/05/20.
//

import Foundation

enum Section: String, CaseIterable {
    case title, message, action, backgroundColor, textColor

    var rowCount: Int {
        switch self {
        case .title, .message, .action:
            return 1
        case .backgroundColor, .textColor:
            return Color.allCases.count
        }
    }
}
