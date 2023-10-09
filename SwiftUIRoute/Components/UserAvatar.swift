//
//  UserAvatar.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/9.
//

import SwiftUI
import Kingfisher

struct UserAvatar: View {
    let url: String?
    let size: CGFloat
    @State var isLoading = true
    
    init(
        url: String?,
        size: CGFloat = screen_width * 0.2
    ) {
        self.url = url
        self.size = size
    }
    
    var body: some View {
        KFImage(URL(string: url))
            .resizable()
            .fade(duration: 0.3)
            .placeholder({ _ in
                Color.b3.ndshimmer()
            })
            .scaledToFill()
            .ndsize(size)
            .background(Color.b3)
            .clipShape(Circle())
    }
}

struct UserAvatar_Previews: PreviewProvider {
    static var previews: some View {
        UserAvatar(
            url: mockImage()
        )
    }
}
