//
//  StateObject+.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/10.
//

import SwiftUI

extension StateObject {
    @inlinable init(_ value: @escaping () -> ObjectType) where ObjectType : ObservableObject {
        self.init(wrappedValue: value())
    }
}
