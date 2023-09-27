//
//  Color+.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/27.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
    
    static var random: Color {
        let red = Double(arc4random()%256)/255.0
        let green = Double(arc4random()%256)/255.0
        let blue = Double(arc4random()%256)/255.0
        return Color(.sRGB, red: red, green: green, blue: blue, opacity: 1)
    }
}

// MARK: - 主题
extension Color {
    static let acc1 = Color(hex: "5FB3F8")
    static let acc2 = Color(hex: "5380BE")
    static let f1 = Color(hex: "333333")
    static let f2 = Color(hex: "666666")
    static let f3 = Color(hex: "999999")
    static let b1 = Color(hex: "FDFDFD")
    static let b2 = Color(hex: "F0F0F0")
    static let b3 = Color(hex: "E3E3E3")
    static let b4 = Color(hex: "DBDADD")
    static let l1 = Color(hex: "EBEBEB")
    static let l2 = Color(hex: "E1E1E1")
//    static let black = Color(hex: "000000")
//    static let white = Color(hex: "FFFFFF")
//    static let orange = Color(hex: "F07748")
//    static let perpule = Color(hex: "AA97BE")
//    static let pink = Color(hex: "CD6484")
//    static let red = Color(hex: "D95B5F")
//    static let yellow = Color(hex: "F4BA5E")
}
