//
//  BaseViewModel.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/8.
//

import Foundation

class BaseViewModel: ObservableObject {
    @Published var requestState = RequestState.ok
    var isLoading: Bool { requestState.isLoading }
}

/**
 * 请求
 */
enum RequestState {
    case loading, needRetry, okButEmpty, ok
    
    var isLoading: Bool { self == .loading }
    var isEmpty: Bool { self == .okButEmpty }
}
