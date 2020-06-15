//
//  BViewController.swift
//  2ndPractice
//
//  Created by mac on 2020/06/15.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit


class BViewController: UIViewController {
    
    let countLbl2 = UILabel()
    let moveBtn2 = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        countLbl2.text = ("\(count)")
        countLbl2.backgroundColor = .blue
        countLbl2.frame = CGRect(x: 150, y: 300, width: 50, height: 50)
        countLbl2.textAlignment = .center
        view.addSubview(countLbl2)
        
        moveBtn2.setTitle("return", for: .normal)
        moveBtn2.backgroundColor = .red
        moveBtn2.frame = CGRect(x: 150, y: 500, width: 100, height: 50)
        moveBtn2.addTarget(self, action: #selector(moveTabBtn(_:)), for: .touchUpInside)
        view.addSubview(moveBtn2)
    }
    @objc private func moveTabBtn(_ sender: UIButton) {
        guard let vc = presentingViewController as? ViewController else { return }
        count += 1
        vc.countLbl.text = "\(count)"
        dismiss(animated: true, completion: nil)
    }
}
