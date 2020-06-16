//
//  ViewController.swift
//  6thPractice
//
//  Created by mac on 2020/06/16.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let redView = UIView()
    let blueView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        setupUI()
        //좌우 반전이 필요할 경우엔 viewDidLoad가 아닌 viewSafeAreaInsetsDidChange에 넣어야함
    }

    private func setupUI() {
        let viewW = view.frame.width
        let viewH = view.frame.height
        let safeT = view.safeAreaInsets.top
        let safeB = view.safeAreaInsets.bottom
        let safeL = view.safeAreaInsets.left
        let safeR = view.safeAreaInsets.right
        
        redView.frame = CGRect(x: safeL + 20,
                               y: safeT + 20,
                               width: ((viewW-safeL-safeR)/2 - 25),
                               height: (viewH-safeT-safeB) - 50)
        redView.backgroundColor = .red
        view.addSubview(redView)
        
        blueView.frame = CGRect(x: redView.frame.maxX + 10,
                                y: redView.frame.minY,
                                width: redView.frame.width,
                                height: redView.frame.height)
        blueView.backgroundColor = .blue
        view.addSubview(blueView)
    }
    
}

