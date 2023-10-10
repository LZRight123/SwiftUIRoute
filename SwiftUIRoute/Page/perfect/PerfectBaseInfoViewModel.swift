//
//  PerfectBaseInfoViewModel.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/9.
//

import Foundation
import ZLPhotoBrowser

class PerfectBaseInfoViewModel: BaseViewModel {
    @Published var icon: ZLResultModel? = nil
    @Published var nickName = ""
    @Published var gender: GenderType? = nil
    var showImage: Any? { icon?.image ?? mockImage() }
    
    func showPicVC() {
        ZLPhotoConfiguration.default().maxSelectCount = 1
        let ps = ZLPhotoPreviewSheet(results: [])
        ps.selectImageBlock  = { [weak self] results, isOriginal in
            self?.icon = results.first
        }
        ps.showPhotoLibrary(sender: RouteStore.shared.topViewController!)
    }
    
    func submit() {
        guard let image = icon?.image else {
            NDToast.show(text: "请选择头像~")
            return
        }
        
        guard !nickName.isEmpty else {
            NDToast.show(text: "请输入昵称~")
            return
        }

        guard gender != nil else {
            NDToast.show(text: "请选择性别~")
            return
        }
        
        requestState = .loading
        Task {
            let headImage = await OSSManager.shared.uploadImage(image)
            guard headImage != nil else {
                DispatchQueue.main.sync {
                    requestState = .ok
                    NDToast.show(text: "上传头像失败~")
                }
                return
            }
            // 上传资料
            let target = UserApi.update(.init(headImg: headImage, gender: gender?.rawValue, nickname: nickName))
            let response = await Networking.request_async(target)
            DispatchQueue.main.sync {
                if response.isSuccess {
                    LocalUserMananger.shared.userInfo.status = 1
                    RouteStore.shared.routeToMain()
                } else {
                    requestState = .ok
                    NDToast.show(text: "上传资料失败~")
                }
            }
            
        }
    }
}
