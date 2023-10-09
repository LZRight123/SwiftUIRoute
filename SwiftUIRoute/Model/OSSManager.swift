//
//  QiniuManager.swift
//  Naduo
//
//  Created by 赵翔宇 on 2023/3/27.
//

import Foundation
import Qiniu
import SwifterSwift

// 七牛云传图Token
fileprivate struct UploadToken: Convertible {
    var token: String = ""
}

class OSSManager {
    static let shared: OSSManager = .init()

    // 上传多张图片
    func uploadImages(_ uiimages: [UIImage]) async -> [String] {
        var urls: [String] = []

        // 并行上传每一张图片
        await withTaskGroup(of: String.self) { group in
            for uiimage in uiimages {
                group.addTask {
                    do {
                        // 上传图片并获得地址
                        let photoUrl = try await self.uploadImage(uiimage, progressBlock: { _ in

                        })
                        return photoUrl
                    } catch {
                        return ""
                    }
                }
            }

            for await url in group {
                if !url.isEmpty {
                    urls.append(url)
                    ndlog("已上传（\(urls.count)/\(uiimages.count)）")
                }
            }
        }
        
        return urls
      
    }

    func uploadImage(_ uiimage: UIImage) async -> String? {
        do {
            // 先上传图片
            let headurl = try await self.uploadImage(uiimage, progressBlock: { _ in

            })
            return headurl
        } catch {
            NDToast.show(text: error.localizedDescription)
            return nil
        }
    }

    func uploadImage(_ image: UIImage, progressBlock: @escaping (Float) -> Void) async throws -> String {
        // 从服务器获取上传Token
        let (r, token) = await Networking.requestObject_async(CommonApi.obtainToken(), modeType: UploadToken.self)
        // 拿到Token，上传图片，否则抛出错误
        guard r.is200Ok, let token = token?.token,!token.isEmpty else { throw NSError(domain: "上传失败？", code: -10) }
        let url = try await self.uploadImageAsync(image, token: token, progressBlock: progressBlock)
        return url
    }

    // 改造为异步 async
    func uploadImageAsync(_ image: UIImage, token: String, progressBlock: @escaping (Float) -> Void) async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            uploadImage(image, token: token, progressBlock: progressBlock) { url in
                if let url = url {
                    continuation.resume(returning: url)
                } else {
                    continuation.resume(throwing: NSError(domain: "上传失败？", code: -10))
                }
            }
        }
    }

    // 该函数使用七牛云进行图片上传，返回上传成功后的图片URL字符串
    func uploadImage(_ image: UIImage,
                     token: String,
                     progressBlock: @escaping (Float) -> Void,
                     completion: @escaping (String?) -> Void)
    {
        // 使用七牛云SDK初始化一个配置对象
        let config = QNConfiguration.build { builder in
            // 是否使用HTTPS上传，默认是使用HTTP上传
            builder?.useHttps = true
        }
        //  其中，`mime` 参数为上传文件的 MIME 类型，在上传图片时通常设置为 `image/jpeg`；
        //  `progressHandler` 为上传进度回调，可用于实时更新进度；
        //  `params` 为上传时可携带的自定义参数，可以传入一个字典类型；
        //  `checkCrc` 表示是否启用校验，一般设置为 `true`；
        //  `cancellationSignal` 表示是否启用取消上传功能，可以传入一个闭包类型，用于检测取消条件并返回是否取消上传的结果。
        let option = QNUploadOption(
            mime: "image/jpeg",
            progressHandler: { key, percent in
                print("\(String(describing: key)) 上传进度：\(percent)%")
                progressBlock(percent)
            },
            params: nil,
            checkCrc: true,
            cancellationSignal: nil
        )

        // 使用配置对象初始化一个上传管理器
        let uploadManager = QNUploadManager(configuration: config)

        // 将UIImage对象转换为NSData对象，准备进行上传
        let data = image.jpegData(compressionQuality: 0.27) // 这里的0.8表示压缩质量，可以自行调整

//        `key` 是表示上传后在七牛云存储空间中保存的文件名或路径，也可以称为文件的键或标识符。
        let key =
        (ProjectConfig.env == .test ? "t/" : "p/")
                + LocalUserMananger.shared.userInfo.id.string + "_"
                + "ios" + "_"
                + UUID().uuidString + "_"
                + Date().string(withFormat: "yyyyMMdd")
                + ".jpg"

        // 使用上传管理器进行上传，并在上传成功或失败时调用指定的回调函数
        uploadManager?.put(data, key: key, token: token, complete: { responseInfo, _, resp in
            if let error = responseInfo?.error {
                print("图片上传失败：\(error.localizedDescription)")
                completion(nil) // 调用回调函数，并传入nil表示上传失败
            } else {
                if let urlString = resp?["key"] as? String {
                    // 使用拼接的方法生成完整的URL字符串
                    let fullURLString = urlString
                    print("图片上传成功：\(fullURLString)")
                    completion(fullURLString) // 调用回调函数，并传入完整的URL字符串表示上传成功
                } else {
                    print("图片上传失败：未能获取上传成功后的URL字符串")
                    completion(nil) // 调用回调函数，并传入nil表示上传失败
                }
            }
        }, option: option)
    }
}
