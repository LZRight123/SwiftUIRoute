//
//  TestApi.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/27.
//

import Foundation

enum TestApi: NDTargetType {
    case codeRegister(phone: String, code: String)
    
    var method: HTTPRequestMethod { .post }
    
    var path: String {
        "naduo/api/user"
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .codeRegister(let phone, let code): return ["phone": phone, "code": code]
        }
    }
}
