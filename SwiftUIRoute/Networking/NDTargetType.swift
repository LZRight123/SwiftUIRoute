//
//  NDTargetType.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/27.
//

import Moya
import SwifterSwift

public typealias HTTPRequestMethod = Moya.Method

protocol NDTargetType: TargetType {
    var parameters: [String: Any]? { get }
    var parameterEncoding: ParameterEncoding { get }
}

/// MARK: - 自有扩展
extension NDTargetType {
    var parameters: [String: Any]? { nil }
    
    var parameterEncoding: ParameterEncoding {
        switch method {
        case .get: return URLEncoding.default
        default: return JSONEncoding.default
        }
    }
}

/// MARK: - Moya 扩展
extension NDTargetType {
    var baseURL: URL {
        URL(string: ProjectConfig.baseUrl) ?? URL(string: "https://test.com")!
    }
    
    var path: String { "" }
    
    var sampleData: Data {
        "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch method {
        case .get:
            if let parameters = parameters {
                return .requestParameters(parameters: parameters, encoding: parameterEncoding)
            }
            return .requestPlain
        case .post, .put, .delete:
            return .requestParameters(parameters: parameters ?? [:], encoding: parameterEncoding)

        default:
            return .requestPlain
        }
    }
    
    
    var headers: [String : String]? {
        var headers: [String: String] = [:]

        // 常规信息
        let standardHeader = [
            "version": "1.",
            "timestamp": Date().timeIntervalSince1970.string,
            "device": UIDevice.current.name,
            "os": UIDevice.current.systemVersion,
            "model": UIDevice.current.localizedModel,
            "DeviceToken": UserDefaults.standard.string(forKey: "DeviceToken")
        ]
        headers["standard-head"] = standardHeader.jsonString()
        // 追踪 ID
//        #if targetEnvironment(simulator)
//            headers["token"] = "83f6223abbed5c02574490a5f2f64010"
//        #else
//            if !UserManager.shared.AccessToken.isEmpty {
//                headers["token"] = UserManager.shared.AccessToken
//            }
//        #endif

        // 设备信息
        headers["device-type"] = UIDevice.current.model
        headers["device-uuid"] = UIDevice.current.identifierForVendor?.uuidString ?? ""
        headers["device-name"] = UIDevice.current.name
        headers["device-system"] = UIDevice.current.systemName
        headers["device-system-version"] = UIDevice.current.systemVersion

        // App 信息
        headers["app-version"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        headers["app-build"] = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
        headers["app-bundle-identifier"] = Bundle.main.bundleIdentifier ?? ""

        return headers
    }

}
