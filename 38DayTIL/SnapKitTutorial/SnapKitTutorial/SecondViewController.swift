//
//  SecondViewController.swift
//  SnapKitTutorial
//
//  Created by mac on 2020/06/09.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController {
    
    lazy var snapView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .purple
        view.layer.opacity = 0.9
        return view
    }()
    
    lazy var snapLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 22)
        label.text = "Exploring SnapKit"
        label.textColor = .white
        return label
    }()
    
    lazy var snapBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitle("Try out SnapKit!", for: .normal)
        button.setTitleColor(.purple, for: .normal)
        button.addTarget(self, action: #selector(didTabBackBtn(_:)), for: .touchUpInside)
        return button
    }()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        self.view.addSubview(snapView)
        snapView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(200)
        }
        
        self.snapView.addSubview(snapLabel)
        snapLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
        self.snapView.addSubview(snapBtn)
        snapBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(60)
        }
    }
    @objc func didTabBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
    }
}
