//
//  NDBottomSheetItem.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/9.
//

import SwiftUI

struct NDBottomSheetItem: View {
    let text: String
    let isSelected: Bool
    let onClick: () -> Void
    
    init(text: String, isSelected: Bool = false, onClick: @escaping () -> Void = {}) {
        self.text = text
        self.isSelected = isSelected
        self.onClick = onClick
    }
    
    var body: some View {
        Button {
            RouteStore.shared.pop()
            onClick()
        } label: {
            HStack(spacing: NDPadding.content) {
                Text(text)
                    .ndfont(.body1, textColor: isSelected ? .acc1 : .f1)
                Spacer()
//                Text("选中")
            }
            .frame(maxWidth: .infinity)
            .frame(height: 36)
            .padding(.horizontal, NDPadding.content)
            .padding(.vertical, NDPadding.padding18_0_618)
            .background(Color.white)
        }
    }
}

