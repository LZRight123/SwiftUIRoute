//
//  PetAdoptCompletedView.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/9.
//

import SwiftUI

struct PetAdoptCompletedView: View {
    var body: some View {
        NDScaffold(
            topBar: {
                NDNavBar {
                    Text("完成领养")
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

extension PetAdoptCompletedView : Routable {
    var page: Route.Page { .petAdoptcompleted }
}

struct PetAdoptCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        PetAdoptCompletedView()
    }
}
