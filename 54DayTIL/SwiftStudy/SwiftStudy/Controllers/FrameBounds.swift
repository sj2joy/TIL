//
//  Practice.swift
//  SwiftStudy
//
//  Created by mac on 2020/07/20.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class FrameBounds: UIViewController {
    
    let blueView = UIView()
    let redView = UIView()
    let greenView = UIView()
    let count: CGFloat = 30
    
    override var description: String { "Practice 1 - Frame & Bound" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Frame & Bound"
        setupUI()
    }
    private func setupUI() {
        
        blueView.frame = CGRect(x: view.safeAreaInsets.left + count,
                                y: view.safeAreaInsets.top + count * 2,
                                width: view.frame.size.width - count * 2,
                                height: view.frame.size.height - count * 2)
        blueView.backgroundColor = .blue
        view.addSubview(blueView)
        
        redView.frame = CGRect(x: blueView.safeAreaInsets.left + 30,
                               y: blueView.safeAreaInsets.top + 30,
                               width: blueView.frame.size.width - 60,
                               height: blueView.frame.size.height - 60)
        redView.backgroundColor = .red
        blueView.addSubview(redView)
        
        greenView.frame = CGRect(x: redView.safeAreaInsets.left + 30,
                                 y: redView.safeAreaInsets.top + 30,
                                 width: redView.frame.size.width - 60,
                                 height: redView.frame.size.height - 60)
        greenView.backgroundColor = .green
        redView.addSubview(greenView)
    }
    
}
