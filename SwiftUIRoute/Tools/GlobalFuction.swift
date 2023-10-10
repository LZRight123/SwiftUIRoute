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

func hiddenKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}

func ndlog(_ items: Any...) {
    #if DEBUG
    print(items)
    #endif
}


let screen_width = UIScreen.main.bounds.width
let screen_height = UIScreen.main.bounds.height
func mockImage() -> String {
    let int =  Int.random(in: 180...200)
    return  "https://picsum.photos/\(int)/\(int)"
}
