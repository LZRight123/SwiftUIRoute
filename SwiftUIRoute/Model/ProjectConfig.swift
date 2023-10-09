//
//  ProjectConfig.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/27.
//

@_exported import SwiftUI
@_exported import UIKit



struct ProjectConfig {
    enum Env {
    case test, pro
    }
    
    static let env = Env.test
    
    static var baseUrl: String {
        switch env {
        case .test: return "https://test.naduo.love"
        case .pro: return "https://app.naduo.love"
        }
    }
}
