//
//  UploadUserAvatar.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/9.
//

import SwiftUI
import ZLPhotoBrowser

struct UploadUserAvatar: View {
    let model: Any?
    let size: CGFloat
    let onClick: () -> Void
    
    init(model: Any?, size: CGFloat = 100, onClick: @escaping () -> Void = {}) {
        self.model = model
        self.size = size
        self.onClick = onClick
    }
    
    var body: some View {
        Button {
            onClick()
        } label: {
            Group {
                if let image = model as? UIImage {
                    Image(uiImage: image)
                        .resizable()
                        .ndsize(size)
                        .clipShape(Circle())
                } else {
                    UserAvatar(url: model as? String, size: size)
                }
            }
            .modifier(UploadUserAvatarModifier(showCamera: true))
            
        }
//        .ndbuttonstyleclear()
    }
}

private struct UploadUserAvatarModifier : ViewModifier {
    let showCamera: Bool
    func body(content: Content) -> some View {
        if showCamera {
            content.overlay(
                ZStack {
                    Image("camera")
                        .resizable()
                        .ndsize(24)
                        .foregroundColor(.f2)
                }
                    .padding(4)
                    .background(Color.b3)
                    .clipShape(Circle()),
                alignment: .bottomTrailing
            )
        } else {
            content
        }
    }
}

struct UploadUserAvatar_Previews: PreviewProvider {
    static var previews: some View {
        UploadUserAvatar(
            model: mockImage(),
            size: 100
        )
    }
}
