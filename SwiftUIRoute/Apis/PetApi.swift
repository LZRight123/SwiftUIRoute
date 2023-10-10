//
//  PetApi.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/10.
//

import Foundation

enum PetApi : NDTargetType {
    case characterMatch(_ body: CharacterMatchParams)
    
    var method: HTTPRequestMethod {
        switch self {
        default: return .post
        }
    }
    
    var path: String {
        switch self {
        case .characterMatch: return "vpapp/api/pet/characterMatch"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .characterMatch(body): return body.kj.JSONObject()
        }
    }
}

// MARK: - 入能
extension PetApi {
    struct CharacterMatchParams: Convertible {
        var characters: [String]?
        var category: Int =  CategoryType.pet.rawValue
    }
}


/**
 // 性格匹配 https://app.apifox.com/link/project/3037643/apis/api-97024682
 @POST("api/pet/characterMatch")
 suspend fun characterMatch(@Body body: CharacterMatchParams): NetworkResponse<PetResult>
 
 */
