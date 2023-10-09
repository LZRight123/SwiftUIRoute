//
//  LoginView.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject var vm = LoginViewModel()
    
    var body: some View {
        NDScaffold(
            isShowLoading: vm.isLoading,
            topBar: nil
        ) {
            VStack(spacing: 24) {
                TextField("输入手机号", text: $vm.phone)
                    .ndNormal()
                    .frame(maxWidth: .infinity, minHeight: 56)
                    .ndunderline()
                    .onChange(of: vm.phone) { newValue in
                        vm.phone = String(newValue.prefix(11))
                    }
                
                HStack(spacing: 10) {
                    TextField("输入验证码", text: $vm.code)
                        .ndNormal()
                        .frame(maxWidth: .infinity)
                        .onChange(of: vm.code) { newValue in
                            vm.code = String(newValue.prefix(4))
                        }
                    
                    Button {
                        vm.sendCode()
                    } label: {
                        Text(
                            vm.countDown == 0 ? "发送验证码" : "剩余\(vm.countDown)s"
                        )
                        .ndsmall()
                    }
                    .ndbuttonstyle(.small(), isLoading: vm.isSendCoding)
                    .ndenabled( vm.countDown == 0 && vm.phone.count == 11)
                    
                }
                .frame(minHeight: 56)
                .ndunderline()
                
                Spacer()
                
                Button {
                    vm.clickLogin()
                } label: {
                    Text("登录").ndlarge()
                }
                .ndbuttonstyle()
                .ndenabled(vm.phone.count >= 11 && vm.code.count >= 4)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(18)
            .padding(.top, 100)
        }
    }
}

extension LoginView: Routable {
    var page: Route.Page { .login }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
