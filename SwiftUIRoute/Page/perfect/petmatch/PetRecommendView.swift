//
//  PetRecommendView.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/10.
//

import SwiftUI

struct PetRecommendView: View , Routable {
    var page: Route.Page { .petRecommend }
    @StateObject var vm: PetRecommendViewModel
    init(pet: PetModel) {
        _vm = StateObject {
            PetRecommendViewModel(pet)
        }
    }
    
    var body: some View {
        NDScaffold(
            title: "智能推荐"
        ) {
            VStack {
                UserAvatar(url: vm.pet.headImg)
                Text(vm.pet.name).ndfont(.title2, textColor: .acc1)
                    .fontWeight(.bold)
                Spacer()
            }
        }
    }
}


class PetRecommendViewModel: BaseViewModel {
    let pet: PetModel
    
    init(_ pet: PetModel) {
        self.pet = pet
    }
}
