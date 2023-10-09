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
    @Published var gender: GenderType? = nil
    var showImage: Any? { icon?.image ?? mockImage() }
    
    func showPicVC() {
        ZLPhotoConfiguration.default().maxSelectCount = 1
        let ps = ZLPhotoPreviewSheet(results: [])
        ps.selectImageBlock  = { [weak self] results, isOriginal in
            self?.icon = results.first
        }
        ps.showPreview(sender: RouteStore.shared.topViewController!)
    }
    
    func submit() {
        guard let image = icon?.image else {
            NDToast.show(text: "请选择头像")
            return
        }

        Task {
            let headImage = await OSSManager.shared.uploadImage(image)
            guard headImage != nil else {
                NDToast.show(text: "上传头像失败~")
                return
            }
            // 上传资料
            ndlog(headImage)
        }
    }
}
