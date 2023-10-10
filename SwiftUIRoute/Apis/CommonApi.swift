//
//  CommonApi.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/8.
//

import Foundation

enum CommonApi: NDTargetType {
    case obtainCode(body: SMSParameters)
    case obtainToken(scope: String = "naduo-files")
    case getStep
    case characters

    var method: HTTPRequestMethod {
        switch  self {
        case .getStep, .characters: return .get
        default: return .post
        }
    }
    
    var path: String {
        switch  self {
        case .obtainCode: return "naduo-common/api/qn/sms/obtainCode"
        case .obtainToken: return "naduo-common/api/qn/oss/obtainToken"
        case .getStep: return "vpapp/api/common/getStep"
        case .characters: return "vpapp/api/common/characters"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .obtainCode(let body): return body.kj.JSONObject()
        case .obtainToken(let scope): return ["scope": scope]
        default: return nil
        }
    }
}

// MARK: - 入参
extension CommonApi {
    struct SMSParameters: Convertible {
        var phone: String?
    }
}

// MARK: - response wrap
extension CommonApi {
    struct Characters {
        
    }
}

