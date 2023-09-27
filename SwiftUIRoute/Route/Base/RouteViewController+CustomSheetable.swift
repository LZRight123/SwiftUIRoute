//
//  RouteViewController+CustomSheetable.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/27.
//

import PanModal
import SwiftUI

/**
 * PanModalPresentable
 */
extension RouteViewController: PanModalPresentable {
    var panScrollable: UIScrollView? { targetPanModal?.panScrollable ?? nil }

    var topOffset: CGFloat { targetPanModal?.topOffset ?? view.safeAreaInsets.top }
    
    var shortFormHeight: PanModalHeight { targetPanModal?.shortFormHeight ?? longFormHeight }
    
    var longFormHeight: PanModalHeight { targetPanModal?.longFormHeight ?? .maxHeight }

    var panModalBackgroundColor: UIColor { .init(targetPanModal?.panModalBackgroundColor ?? .black) }
            
    var dragIndicatorBackgroundColor: UIColor { .init(targetPanModal?.dragIndicatorBackgroundColor ?? Color.red) }
    
    var showDragIndicator: Bool { targetPanModal?.showDragIndicator ?? false }
    
    var allowsDragToDismiss: Bool { targetPanModal?.allowsTapToDismiss ?? true }
    
    var allowsTapToDismiss: Bool { targetPanModal?.allowsTapToDismiss ?? true }
    
    var cornerRadius: CGFloat { 0 }
}


protocol CustomSheetable {
    var panScrollable: UIScrollView? { get }
    var topOffset: CGFloat { get }
    var shortFormHeight: PanModalHeight { get }
    var longFormHeight: PanModalHeight { get }
    var panModalBackgroundColor: Color { get }
    var dragIndicatorBackgroundColor: Color { get }
    var showDragIndicator: Bool { get }
    var allowsDragToDismiss: Bool { get }
    var allowsTapToDismiss: Bool { get }
}

extension CustomSheetable {
    var panScrollable: UIScrollView? { nil }
    var topOffset: CGFloat { UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0 }
    var shortFormHeight: PanModalHeight { longFormHeight }
    var longFormHeight: PanModalHeight { .contentHeightIgnoringSafeArea(300) }
    var panModalBackgroundColor: Color { Color.black.opacity(0.5) }
    var dragIndicatorBackgroundColor: Color { Color.red }
    var showDragIndicator: Bool { false }
    var allowsDragToDismiss: Bool { true }
    var allowsTapToDismiss: Bool { true }
}
