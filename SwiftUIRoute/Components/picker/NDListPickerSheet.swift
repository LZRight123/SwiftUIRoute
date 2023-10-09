//
//  NDListPickerSheet.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/9.
//

import SwiftUI

struct NDListPickerSheet<Content: View>: View, Routable, CustomSheetable {
    var page: Route.Page { .sheet }
    
    let title: String
    @ViewBuilder let content: Content
    
    var body: some View {
        NDBottomSheetView {
            NDBottomSheetCard(title: title) {
                content
            }
        }
    }
}


struct NDListPickerSheet_Previews: PreviewProvider {
    static var previews: some View {
        NDListPickerSheet(
            title:"标题"
        ) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0..<5) { _ in
                    NDBottomSheetItem(text: "text")
                }
            }
        }
    }
}
