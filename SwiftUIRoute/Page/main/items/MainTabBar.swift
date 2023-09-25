//
//  MainTabBar.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/25.
//

import SwiftUI

struct MainTabBar: View {
    @EnvironmentObject var vm: MainViewModel
    let onClickItem: (TabBarType) -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabBarType.allCases, id: \.self) { type in
                let isSelected = type ==  vm.currentTabBarType
                Button {
                    vm.currentTabBarType = type
                    onClickItem(type)
                } label: {
                    VStack {
                        Text(type.title)
                        Text(type.icon)
                    }
                    .foregroundColor(isSelected ? Color.red : Color.black)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .frame(height: 52)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct MainTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBar(onClickItem: { _ in}) 
    }
}
