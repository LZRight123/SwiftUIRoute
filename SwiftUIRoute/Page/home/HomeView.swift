//
//  HomeView.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/27.
//

import SwiftUI
import Toaster

struct TestModel: Convertible {
    var timestamp: Int = 0
}
struct HomeView: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea(.all)
            
            VStack(spacing: 20) {
                Button {
                    RouteStore.shared.present(PopView(pageType: .sheet))
                } label: {
                    Text("tap bottom sheet")
                        .foregroundColor(Color.red)
                }
                
                Button {
                    RouteStore.shared.present(PopView(pageType: .alert), modal: .custom, transition: FullscreenAnimatorDelegate.default)
                    Task {
                        ToastView.appearance().bottomOffsetPortrait = UIScreen.main.bounds.height * 0.5

                        Toast(text: "123", duration: Delay.long).show()
                    }
                } label: {
                    Text("tap popover")
                        .foregroundColor(Color.red)
                }

                Button {
                    RouteStore.shared.push(TestView())
                } label: {
                    Text("push test")
                        .foregroundColor(Color.red)
                }
                
                
                Button {
                    Task {
                        NDProgress.show()
                        await localDealy(dealy: 2000)
                        NDProgress.dismiss()
                    }
                } label: {
                    Text("call api")
                        .foregroundColor(Color.red)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct PopView: View {
    let pageType: Route.Page
    
    var body: some View {
        if pageType == .sheet {
            VStack {
                Spacer(minLength: 0)
                Color.random.ignoresSafeArea().onTapGesture {
                    
                }
                .frame(height: 300)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                RouteStore.shared.pop()
            }
        } else {
            Color.random.ignoresSafeArea().onTapGesture {
                RouteStore.shared.pop()
            }
            .frame(height: 300)
            .frame(width: 300)
        }
    }
}
extension PopView: Routable, CustomSheetable {
    var page: Route.Page { pageType }
}
