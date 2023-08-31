//
//  ViewController.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/8/31.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        // Do any additional setup after loading the view.
        let btn = UIButton(frame: view.bounds)
        btn.backgroundColor = UIColor.blue
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(click), for: .touchUpInside)
    }
    
    @objc
    func click()  {
        RouteStore.shared.push(RootView())
    }


}

