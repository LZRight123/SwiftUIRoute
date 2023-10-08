//
//  LocalUserManager.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/8.
//

import Foundation

class LocalUserMananger: ObservableObject {
    static let shared = LocalUserMananger()
    
    init() {
        
        UserInfo()
    }
}
