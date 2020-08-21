//
//  ReadViewController.swift
//  Practice1
//
//  Created by mac on 2020/08/19.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class ReadViewController: UIViewController {

    var emailAddress: String?
    var isUpdate: Bool?
    var intervalValue: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI() {
        let emailLabel = UILabel()
        emailLabel.frame = CGRect(x: 50, y: 100, width: 300, height: 30)
        emailLabel.text = "전달받은 이메일:    \(emailAddress!)"
        view.addSubview(emailLabel)
        
        let updateLabel = UILabel()
        updateLabel.frame = CGRect(x: 50, y:150, width: 300, height: 30)
        updateLabel.text = "업데이트 여부:    \(isUpdate == true ? "업데이트 함" : "업데이트 안함")"
        view.addSubview(updateLabel)
        
        let intervalLabel = UILabel()
        intervalLabel.frame = CGRect(x: 50, y: 200, width: 300, height: 30)
        intervalLabel.text = "업데이트 주기:  \(intervalValue!)분 마다"
        view.addSubview(intervalLabel)
        
    }
}
