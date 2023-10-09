//
//  UploadUserAvatar.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/9.
//

import SwiftUI

struct UploadUserAvatar: View {
    let model: Any?
    let size: CGFloat
    
    init(model: Any?, size: CGFloat = 100) {
        self.model = model
        self.size = size
    }
    
    var body: some View {
        Button {
            
        } label: {
            Group {
                if let url = model as? UIImage {
                    Color.b3.ndsize(size)
                        .clipShape(Circle())
                } else {
                    UserAvatar(url: model as? String, size: size)
                }
            }
            .overlay(
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
        }
//        .ndbuttonstyleclear()
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
