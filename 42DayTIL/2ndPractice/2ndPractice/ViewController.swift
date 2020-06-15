//
//  ViewController.swift
//  2ndPractice
//
//  Created by mac on 2020/06/15.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

var count = 0

class ViewController: UIViewController {
    
    var countLbl = UILabel()
    let moveBtn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        countLbl.text = ("\(count)")
        countLbl.backgroundColor = .blue
        countLbl.frame = CGRect(x: 150, y: 300, width: 50, height: 50)
        countLbl.textAlignment = .center
        view.addSubview(countLbl)
        
        moveBtn.setTitle("Next", for: .normal)
        moveBtn.backgroundColor = .red
        moveBtn.frame = CGRect(x: 150, y: 500, width: 100, height: 50)
        moveBtn.addTarget(self, action: #selector(moveTabBtn(_:)), for: .touchUpInside)
        view.addSubview(moveBtn)
    }
    @objc private func moveTabBtn(_ sender: UIButton) {
        
        let bVc = BViewController()
        bVc.modalPresentationStyle = .fullScreen
        count += 1
        countLbl.text = "\(count)"
        present(bVc, animated:  true)
    }
}

