//
//  AfterLoginViewController.swift
//  SwiftStudy
//
//  Created by mac on 2020/07/22.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class AfterLoginViewController: UIViewController {
    
    let signOutButton = UIButton()
    let titleLabel = UILabel()
    var userId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = userId
        setupUI()
    }
    private func setupUI() {
        titleLabel.text = ""
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.frame = CGRect(x: 90, y: 200, width: 220, height: 70)
        titleLabel.backgroundColor = .lightGray
        view.addSubview(titleLabel)
        
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.setTitleColor( .blue, for: .normal)
        signOutButton.titleLabel?.font = UIFont(name: "Arial", size: 50)
        signOutButton.frame = CGRect(x: 100, y: view.center.y, width: 200, height: 100)
        signOutButton.addTarget(self, action: #selector(didTabBackButton(_:)), for: .touchUpInside)
        view.addSubview(signOutButton)
    }
    @objc private func didTabBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
