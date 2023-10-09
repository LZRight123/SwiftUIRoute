//
//  CommonApi.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/8.
//

import Foundation

enum CommonApi: NDTargetType {
    case obtainCode(body: SMSParameters)
    case getStep
    
    var method: HTTPRequestMethod {
        switch  self {
        case .obtainCode: return .post
        case .getStep: return .get
        }
    }
    
    var path: String {
        switch  self {
        case .obtainCode: return "naduo-common/api/qn/sms/obtainCode"
        case .getStep: return "vpapp/api/common/getStep"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .obtainCode(let body): return body.kj.JSONObject()
        case .getStep: return nil 
        }
    }
}

extension CommonApi {
    struct SMSParameters: Convertible {
        var phone: String?
    }
}
