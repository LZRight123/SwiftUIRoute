//
//  NDTheme.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/9.
//

import SwiftUI

struct NDPadding {
    /*
     页面内容边距统一：padding 18
     元素之间间距：小 4 中 12 大 24 巨大 32
     */
    private static let padding18: CGFloat = 18
    private static let padding4: CGFloat = 4
    private static let padding6: CGFloat = 6
    static let padding8: CGFloat = 8
    private static let padding12: CGFloat = 12
    private static let padding24: CGFloat = 24
    private static let padding32: CGFloat = 32
    static let padding18_0_618: CGFloat = 18 * 0.618
    
    static let content = padding18
    static let min = padding4
    static let mid = padding12
    static let max = padding24
    static let large = padding32
    static let largeButtonVPadding = mid
    static let smallButtonVPadding = padding8
}
