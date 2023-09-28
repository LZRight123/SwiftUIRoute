//
//  Text+.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/27.
//

import SwiftUI

public extension Text {
    func ndfont(_ font: Font, textColor: Color) -> Text {
        self.font(font)
            .foregroundColor(textColor)
    }

    func ndfontSize(_ fontSize: CGFloat, textColor: Color) -> Text {
        self.font(.system(size: fontSize))
            .foregroundColor(textColor)
    }
}
