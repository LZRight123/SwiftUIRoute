//
//  BottomSheetCard.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/9.
//

import SwiftUI

struct NDBottomSheetCard<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .ndfont(.body1, textColor: .f1)
                .fontWeight(.semibold)
                .frame(height: 36)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, NDPadding.content)
                .padding(.vertical, NDPadding.padding18_0_618)
            content
        }
        .background(Color.b2)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(NDPadding.content)
    }
}

