//
//  LocalUserManager.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/8.
//

import Foundation

private let kCurrentToken = "currentToken"
private let kCurrentUserInfo = "currentUserInfo"
private let kStep = "step"
class LocalUserMananger: ObservableObject {
    static let shared = LocalUserMananger()
    
    private(set) var tokenModel = TokenModel()
    @Published var userInfo = UserInfo()
    private(set) var userStep = StepModel()
    var isLogin: Bool {
        !tokenModel.token.isEmpty && !userInfo.xid.isEmpty
    }

    func commonInit()  {
        if let token = TokenModel.getForDisk(fileName: kCurrentToken) {
            tokenModel = token
        }
        if let userInfo = UserInfo.getForDisk(fileName: kCurrentUserInfo) {
            self.userInfo = userInfo
        }
        if let userStep = StepModel.getForDisk(fileName: kStep) {
            self.userStep = userStep
        }
        if isLogin {
            Networking.requestObject(CommonApi.getStep, modeType: StepModel.self) { [weak self] _, stepModel in
                if let stepModel = stepModel {
                    self?.refreshUsecrStep(step: stepModel.step)
                }
            }
            Networking.requestObject(UserApi.baseInfo, modeType: UserInfo.self) { [weak self] _, userInfo in
                if let userInfo = userInfo {
                    self?.refreshUserInfo(model: userInfo)
                }
            }
        }
    }
    
    func loginSuccess(model: TokenModel) {
        tokenModel = model
        tokenModel.cacheOnDisk(fileName: kCurrentToken)
    }
    
    func refreshUserInfo(model: UserInfo) {
        userInfo = model
        // 设置极光别名
        userInfo.cacheOnDisk(fileName: kCurrentUserInfo)
    }
    
    func refreshUsecrStep(step: UserStepIndex) {
        userStep.step = step
        userStep.cacheOnDisk(fileName: kStep)
    }
    
    func logout() {
        loginSuccess(model: .init())
        refreshUserInfo(model: .init())
        refreshUsecrStep(step: .Over)
        RouteStore.shared.routeToMain()
    }
    
    func fetchUserStep() async -> StepModel? {
        
        return nil
    }
}
