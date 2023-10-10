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

enum UserStepIndex: Int, ConvertibleEnum {
    case PetMatch = 1
    case AdoptCompletion = 2 //领养成功
    case Over = 3 // 点击了完成领养
}

enum GenderType: Int, CaseIterable {
    case female = 0 //女
    case male = 1 //男
    var title: String {
        switch self {
        case .female: return "女"
        case .male: return "男"
        }
    }
}


/**
 * category 类型
 */
enum CategoryType: Int, ConvertibleEnum {
    case pet =  1
}
