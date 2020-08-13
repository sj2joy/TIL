//
//  PreViewController.swift
//  MyMemory
//
//  Created by mac on 2020/08/13.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class PreViewController: UIViewController {
    
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let imgView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI() {
        titleLabel.frame = CGRect(x: 16, y: view.safeAreaInsets.top + 90, width: 50, height: 30)
        titleLabel.text = "제목"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        
        contentLabel.frame = CGRect(x: 16, y: titleLabel.frame.maxY + 20, width: 50, height: 30)
        contentLabel.text = "내용"
        view.addSubview(contentLabel)
        
        imgView.frame = CGRect(x: 16, y: 180, width: 340, height: 300)
        imgView.backgroundColor = .yellow
        view.addSubview(imgView)
    }
}
