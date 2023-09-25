//
//  AAEnums.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/25.
//

import Foundation

/**
 * tab bar type
 */
enum TabBarType: CaseIterable {
    case one, two, three, four
    
    var title: String {
        switch self {
        case .one:
            return "one"
        case .two:
            return "two"
        case .three:
            return "three"
        case .four:
            return "four"
        }
    }
    
    var icon: String {
        switch self {
        case .one:
            return "camera"
        case .two:
            return "camera"
        case .three:
            return "camera"
        case .four:
            return "camera"
        }
    }
}
