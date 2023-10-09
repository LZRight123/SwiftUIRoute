//
//  NDButtonSheetView.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/9.
//

import SwiftUI

struct NDBottomSheetView<Content: View>: View {
    @ViewBuilder let content: Content
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(alignment: .leading, spacing: 0) {
                content
                    .onTapGesture {}
            }
            .onTapGesture {}
        }
        .contentShape(Rectangle())
        .onTapGesture {
            RouteStore.shared.pop()
        }

        
    }
}

struct NDBottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        NDBottomSheetView {
            Color.black.frame(height: 100)
        }
    }
}
