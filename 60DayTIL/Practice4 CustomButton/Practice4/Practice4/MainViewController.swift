//
//  ViewController.swift
//  Practice4
//
//  Created by mac on 2020/08/21.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let csBtn = CSButton()
        csBtn.frame = CGRect(x: 30, y: 50, width: 150, height: 30)
        view.addSubview(csBtn)
        setupUI()
    }
    private func setupUI() {
        let rectBtn = CSButton(type: . rect)
        rectBtn.frame = CGRect(x: 30,y: 200, width: 150, height: 30)
        view.addSubview(rectBtn)

        let circleBtn = CSButton(type: .circle)
        circleBtn.frame = CGRect(x: 200, y: 200, width: 150, height: 30)
        view.addSubview(circleBtn)
    }
    
}

