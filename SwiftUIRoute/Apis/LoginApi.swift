//
//  LoginApi.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/8.
//

import Foundation

enum LoginApi: NDTargetType {
    case codeRegister(body: PhoneCodeParams)
    case logout
    
    var method: HTTPRequestMethod {
        switch self {
        case .codeRegister: return .post
        case .logout: return .get
        }
    }

    
    var path: String {
        switch self {
        case .codeRegister: return "vpapp/api/login/codeRegister"
        case .logout: return "vpapp/api/login/logout"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .codeRegister(let body): return body.kj.JSONObject()
        case .logout: return nil
        }
    }
}

//MARK: - 入参
extension LoginApi {
    struct PhoneCodeParams: Convertible {
        var phone: String?
        var code: String?
    }
}
