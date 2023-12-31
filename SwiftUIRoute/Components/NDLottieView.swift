//
//  NSLottieView.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/28.
//

import Lottie
import SwiftUI

// MARK: - 去 https://lottiefiles.com/featured 下载一个免费的动画
struct NDLottieView: UIViewRepresentable {
    let lottieFlie: String
    let animationView = LottieAnimationView()

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let animation = LottieAnimation.named(lottieFlie)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 1
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor), animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }

}

extension NDLottieView {
    func loopMode(_ loopMode: LottieLoopMode) -> Self {
        animationView.loopMode = loopMode
        return self
    }
    
    func speed(_ speed: CGFloat) -> Self {
        DispatchQueue.main.async {
            animationView.animationSpeed = speed
        }
        return self
    }
    
    func play(completion: LottieCompletionBlock? = nil) -> Self {
        DispatchQueue.main.async {
            animationView.play(completion: completion)
        }
        return self
    }
    
    func play(
        fromProgress: AnimationProgressTime? = nil,
        toProgress: AnimationProgressTime,
        loopMode: LottieLoopMode? = nil,
        completion: LottieCompletionBlock? = nil
    ) -> Self {
        DispatchQueue.main.async {
            animationView.play(fromProgress: fromProgress, toProgress: toProgress, loopMode: loopMode, completion: completion)
        }
        return self
    }
}


