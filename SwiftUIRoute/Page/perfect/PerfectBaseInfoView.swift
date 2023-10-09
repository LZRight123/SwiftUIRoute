//
//  PerfectBaseInfoView.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/9.
//

import SwiftUI

struct PerfectBaseInfoView: View {
    var body: some View {
        NDScaffold(
            topBar: {
                NDNavBar {
                    Text("完善资料")
                        .ndfont(.title2, textColor: .f1)
                        .fontWeight(.bold)
                }
            }
        ) {
            VStack {
                Text("123")
                    .ndfont(.body1, textColor: .f1)
            }
        }
    }
}

extension  PerfectBaseInfoView: Routable {
    var page: Route.Page { .perfectBaseInfo }
}

struct PerfectBaseInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PerfectBaseInfoView()
    }
}
