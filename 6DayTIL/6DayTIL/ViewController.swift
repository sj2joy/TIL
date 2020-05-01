//
//  ViewController.swift
//  191122practice
//
//  Created by mac on 2020/04/07.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let blueView = UIView()
    let redView = UIView()
    let greenView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        
        blueView.frame = CGRect(x: view.safeAreaInsets.left + 30, y: view.safeAreaInsets.top + 30, width: view.frame.size.width - 60, height: view.frame.size.height - 60)
        blueView.backgroundColor = .blue
        view.addSubview(blueView)
        
        redView.frame = CGRect(x: 30, y: 30, width: blueView.frame.size.width - 60, height: blueView.frame.size.height - 60)
        redView.backgroundColor = .red
        blueView.addSubview(redView)
        
        greenView.frame = CGRect(x: 30, y: 30, width: redView.frame.size.width - 60, height: redView.frame.size.height - 60)
        greenView.backgroundColor = .green
        redView.addSubview(greenView)
    }

}

