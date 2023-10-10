//
//  GlobalDataStore.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/10.
//

import Foundation

class GlobalDataStore {
    static let shared = GlobalDataStore()
    
    
    func fetchAllIfNeed() {
        Task {
            await fetchCharactersIfNeed()
        }
    }
    
    private var characters = [String]()
    func fetchCharactersIfNeed() async -> [String] {
        if characters.isEmpty {
            let result = await Networking.request_async(CommonApi.characters).json?["data"].arrayObject as? [String]
            characters = result ?? []
        }
        
        return characters
    }
}
