//
//  View+.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/8/31.
//

import SwiftUI

extension View {
    func onPageChanged(debounce: Bool = false, handler: @escaping (Route.Page) -> Void) -> some View {
        onReceive(
            NotificationCenter.default
                .publisher(for: .routePageDidChanged)
                .debounce(for: debounce ? 1 : 0, scheduler: RunLoop.main)
        ) { page in
            guard let page = page.object as? Route.Page else {
                return
            }
            print("⏺ on page changed: \(page.rawValue)")
            handler(page)
        }
    }
}
