//
//  ThirdViewController.swift
//  SnapKitTutorial
//
//  Created by mac on 2020/06/10.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    let circleView1 = UIView()
    let circleView2 = UIView()
    let circleView3 = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        circleView1.translatesAutoresizingMaskIntoConstraints = false
        circleView1.layer.cornerRadius = 150
        circleView1.backgroundColor = .red
        circleView1.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 300, height: 300))
            make.centerX.equalTo(view.center)
            make.centerY.equalTo(view.center)
            view.addSubview(circleView1)
        }
        
        circleView2.translatesAutoresizingMaskIntoConstraints = false
        circleView2.layer.cornerRadius = 125
        circleView2.backgroundColor = .yellow
        circleView2.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 250, height: 250))
            make.centerX.equalTo(view.center)
            make.centerY.equalTo(view.center)
            view.addSubview(circleView2)
        }
        circleView3.translatesAutoresizingMaskIntoConstraints = false
        circleView3.layer.cornerRadius = 100
        circleView3.backgroundColor = .black
        circleView3.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 200, height: 200))
            make.centerX.equalTo(view.center)
            make.centerY.equalTo(view.center)
            view.addSubview(circleView3)
        }
    }
    
}
