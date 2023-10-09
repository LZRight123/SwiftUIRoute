//
//  Text+.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/27.
//

import SwiftUI

extension Text {
    func ndfont(_ font: Font, textColor: Color) -> Text {
        self.font(font)
            .foregroundColor(textColor)
    }
}

// MARK: - 提供给 Button 用
extension Text {
    func ndsmall() -> Text {
        font(.body3).fontWeight(.semibold)
    }
    
    func ndlarge() -> Text {
        font(.body1).fontWeight(.semibold)

    }
}
