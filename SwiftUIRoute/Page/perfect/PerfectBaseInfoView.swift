//
//  PerfectBaseInfoView.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/9.
//

import SwiftUI
import ZLPhotoBrowser

struct PerfectBaseInfoView: View {
    @StateObject var vm = PerfectBaseInfoViewModel()
    
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
            VStack(spacing: NDPadding.max) {
                UploadUserAvatar(model: vm.showImage) {
                    vm.showPicVC()
                }
                Text(vm.gender?.title ?? "选择性别")
                    .ndfont(.body1, textColor: vm.gender == nil ? .f2 : .f1)
                    .onTapGesture {
                        RouteStore.shared.present(
                            NDListPickerSheet(title: "请选择性别"){
                                VStack(alignment: .leading, spacing: 0) {
                                    ForEach(GenderType.allCases, id: \.self) { gender in
                                        NDBottomSheetItem(
                                            text: gender.title,
                                            isSelected: vm.gender == gender
                                        ) {
                                            vm.gender = gender
                                        }
                                    }
                                }
                            }
                        )
                    }
                Spacer()
                Button {
                    vm.submit()
                } label: {
                    Text("确定").ndlarge()
                }
                .ndbuttonstyle()
            }
            .padding(.horizontal, NDPadding.content)
            .padding(.vertical, NDPadding.max)
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
