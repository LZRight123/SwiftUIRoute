//
//  UserInfo.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/8.
//

import Foundation

struct UserInfo: Convertible {
    var id: Int = 0
    var xid: String = "" // "ZA7UBd0c,
    var nickname: String = "" // "cMgtFl,
    var phoneArea: String = "" // "+6",
    var phone: String = "" // "15271327766,
    var headImg: String = "" // "http//files.revome.cn/public/b5f99bda91dfd187157a1c2926a55a27_5.png",
    var status: Int = -1 // 0新用户 1老用户
    var balance: Double = 0.0 // 0.0,
    var coin: Int = 0 // 0,
    var birthday: Int? = nil // null,
    var gender: Int = 0 // 0,
    var deleted: Int = 0 // 0,
    var createTime: Int? = nil // 1690343587000
    
    var isNewUser: Bool { status == 0 }
}
