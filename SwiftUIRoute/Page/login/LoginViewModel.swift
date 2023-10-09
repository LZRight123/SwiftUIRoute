//
//  LoginViewModel.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/8.
//

import Foundation
import Combine

class LoginViewModel: BaseViewModel {
    @Published var phone = "15271327768"
    @Published var code = "1234"
    @Published var countDown = 0
    private var timer: AnyCancellable?
    @Published var isSendCoding = false
    
    func sendCode() {
        isSendCoding = true
        Networking.request(CommonApi.obtainCode(body: .init(phone: phone))) { [weak self] result in
            guard let self = self else { return }
            self.isSendCoding = false
            if result.isSuccess {
                NDToast.show(text: result.message)
                self.beginCountDown()
            } else {
                NDToast.show(text: result.message)
            }
        }
    }
    
    private func beginCountDown() {
        DispatchQueue.main.async {
            self.countDown = 59
            self.timer = Timer.publish(every: 1, on: .main, in: .default)
                .autoconnect()
                .sink { [weak self] _ in
                    guard let self = self else { return }
                    if self.countDown <= 0 {
                        self.timer?.cancel()
                    } else {
                        self.countDown -= 1
                    }
                }
        }
    }
    
    func clickLogin() {
        requestState = .loading
        Task {
            // 1. 登录
            let target = LoginApi.codeRegister(body: .init(phone: phone, code: code))
            let (reponse1, token) =  await Networking.requestObject_async(target, modeType: TokenModel.self)
            guard reponse1.isSuccess && token != nil else {
                NDToast.show(text: reponse1.message)
                DispatchQueue.main.async {
                    self.requestState = .ok
                }
                return
            }
            LocalUserMananger.shared.loginSuccess(model: token!)
            // 2. 成功后获取步骤
            let (_, stepModel) = await Networking.requestObject_async(CommonApi.getStep, modeType: StepModel.self)
            if let step = stepModel?.step {
                LocalUserMananger.shared.refreshUsecrStep(step: step)
            }
            // 3. 获取用户信息
            let (_, userInfo) = await Networking.requestObject_async(UserApi.baseInfo, modeType: UserInfo.self)
            guard userInfo != nil else {
                NDToast.show(text: "登录失败")
                DispatchQueue.main.async {
                    self.requestState = .ok
                }
                return
            }
            LocalUserMananger.shared.refreshUserInfo(model: userInfo!)
            DispatchQueue.main.async {
                RouteStore.shared.routeToMain()
            }
        }
        
    }
    
    deinit {
        timer?.cancel()
    }
}
