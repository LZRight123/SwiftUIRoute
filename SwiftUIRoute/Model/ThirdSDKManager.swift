//
//  ThirdSDKManager.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/9.
//

import Foundation

class ThirdSDKManager {
    static let shared = ThirdSDKManager()
    
    func commonInit() {
        NDToast.commonInit()
        UITextField.appearance().tintColor = .init(.acc1)
    }
}
