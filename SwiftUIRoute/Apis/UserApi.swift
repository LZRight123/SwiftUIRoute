//
//  UserApi.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/8.
//

import Foundation

enum UserApi: NDTargetType {
    case baseInfo
    case update(_ body: UpdateParams)
    
    var method: HTTPRequestMethod {
        switch self {
        default: return .post
        }
    }

    
    var path: String {
        switch self {
        case .baseInfo: return "vpapp/api/user/profile"
        case .update: return "vpapp/api/user/update"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .baseInfo: return nil
        case let .update(body): return body.kj.JSONObject()
        }
    }
}


// MARK: - 入参
extension UserApi {
    struct UpdateParams: Convertible {
        var headImg: String?// 用户图像
        var gender: Int? // 0女 1男
        var nickname: String?// 用户昵称
    }
}
