//
//  ViewController.swift
//  1stpractice
//
//  Created by mac on 2020/06/15.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let plusBtn = UIButton()
    let minusBtn = UIButton()
    let countLbl = UILabel()
    var count: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    private func setupUI() {
        plusBtn.setTitle("+", for: .normal)
        plusBtn.frame = CGRect(x: 100, y: 100, width: 150, height: 150)
        plusBtn.backgroundColor = .blue
        plusBtn.addTarget(self, action: #selector(plusTabBtn(_:)), for: .touchUpInside)
        view.addSubview(plusBtn)
        
        minusBtn.setTitle("-", for: .normal)
        minusBtn.frame = CGRect(x: 100, y: 400, width: 150, height: 150)
        minusBtn.backgroundColor = .red
        minusBtn.addTarget(self, action: #selector(minusTabBtn(_:)), for: .touchUpInside)
        view.addSubview(minusBtn)
        
        countLbl.text = String(count)
        countLbl.textAlignment = .center
        countLbl.frame = CGRect(x: 130, y: 300, width: 100, height: 70)
        countLbl.backgroundColor = .green
        view.addSubview(countLbl)
    }
    
    @objc private func plusTabBtn(_ sender: UIButton) {
        count += 1
        countLbl.tintColor = .blue
        countLbl.text = "\(count)"
    }
    @objc private func minusTabBtn(_ sender: UIButton) {
        count -= 1
        countLbl.tintColor = .red
        countLbl.text = "\(count)"
    }
}

