//
//  UserApi.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/8.
//

import Foundation

enum UserApi: NDTargetType {
    case baseInfo
    
    var method: HTTPRequestMethod {
        switch self {
        case .baseInfo: return .post
        }
    }

    
    var path: String {
        switch self {
        case .baseInfo: return "vpapp/api/user/profile"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .baseInfo: return nil
        }
    }
}
