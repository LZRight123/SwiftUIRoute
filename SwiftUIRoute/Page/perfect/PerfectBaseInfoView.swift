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
            isShowLoading: vm.isLoading,
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
                nickName
                sex
                Spacer()
                Button {
                    vm.submit()
                } label: {
                    Text("确定").ndlarge()
                }
                .ndbuttonstyle(isLoading: vm.isLoading)
            }
            .padding(.horizontal, NDPadding.content)
            .padding(.vertical, NDPadding.max)
        }
        .onTapGesture {
            hiddenKeyboard()
        }
    }
    
    var nickName: some View {
        HStack(spacing: NDPadding.mid) {
            Text("昵称")
                .ndfont(.body1, textColor: .f1)
            TextField(
                "输入昵称",
                text: $vm.nickName
            )
            .ndNormal()
            .accentColor(.red)
        }
        .frame(height: 56)
        .ndunderline()
    }
    
    var sex: some View {
        HStack(spacing: NDPadding.mid) {
            Text("性别")
                .ndfont(.body1, textColor: .f1)
            Text(vm.gender?.title ?? "选择性别")
                .ndfont(.body1, textColor: vm.gender == nil ? .f3 : .f1)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 56)
        .contentShape(Rectangle())
        .onTapGesture {
            hiddenKeyboard()
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
        .ndunderline()
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
