//
//  GlobalFuction.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/25.
//

import Foundation

func localDealy(dealy: Int) async {
    try? await Task.sleep(nanoseconds: UInt64(dealy) * 1000 * 1000)
}

func ndlog(_ items: Any...) {
    #if DEBUG
    print(items)
    #endif
}
