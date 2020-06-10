//
//  ViewController.swift
//  SnapKitTutorial
//
//  Created by mac on 2020/06/09.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
          override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
        }
    
        func setupUI() {
            let nextBtn2 = UIButton()
            nextBtn2.backgroundColor = .white
            nextBtn2.setTitle("다음으로", for: .normal)
            nextBtn2.setTitleColor(UIColor.blue, for: .normal)
            nextBtn2.layer.cornerRadius = 5
            nextBtn2.addTarget(self, action: #selector(didTabNextBtn2(_:)), for: .touchUpInside)
            
            let nextBtn = UIButton()
            nextBtn.backgroundColor = .white
            nextBtn.setTitle("다음으로", for: .normal)
            nextBtn.setTitleColor(UIColor.blue, for: .normal)
            nextBtn.layer.cornerRadius = 5
            nextBtn.addTarget(self, action: #selector(didTabNextBtn(_:)), for: .touchUpInside)
            
            let childView = UIView()
            childView.backgroundColor = .red
            childView.layer.cornerRadius = 20
            view.addSubview(childView)
    
            let bottomView = UIView()
            bottomView.backgroundColor = .yellow
            bottomView.layer.cornerRadius = 20
            view.addSubview(bottomView)
    
            let littleView = UIView()
            littleView.backgroundColor = .blue
            littleView.layer.cornerRadius = 20
            childView.addSubview(littleView)
    
            let subView = UIView()
            subView.backgroundColor = .green
            subView.layer.cornerRadius = 20
            bottomView.addSubview(subView)
            
            nextBtn2.snp.makeConstraints { (make) in
                make.size.equalTo(CGSize(width: 100, height: 30))
                make.topMargin.equalTo(littleView).offset(80)
                make.leftMargin.equalTo(littleView).offset(50)
                littleView.addSubview(nextBtn2)
            }
            
            nextBtn.snp.makeConstraints { (make) in
                           make.size.equalTo(CGSize(width: 100, height: 30))
                           make.topMargin.equalTo(subView).offset(80)
                           make.leftMargin.equalTo(subView).offset(50)
                           subView.addSubview(nextBtn)
                       }
    
            childView.snp.makeConstraints { (make) in
                make.size.equalTo(CGSize(width: 300, height: 300))
                make.top.equalTo(view.snp.top).offset(30)
                make.centerX.equalTo(view)
            }
            bottomView.snp.makeConstraints { (make) in
                make.size.equalTo(childView)
                make.top.equalTo(childView.snp.bottom).offset(10)
                make.centerX.equalTo(view)
            }
            littleView.snp.makeConstraints { (make) in
                make.size.equalTo(CGSize(width: 200, height: 200))
                //            make.topMargin.equalTo(childView).offset(50)
                //            make.leftMargin.equalTo(childView).offset(50)
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            subView.snp.makeConstraints { (make) in
                make.size.equalTo(CGSize(width: 200, height: 200))
                            make.topMargin.equalToSuperview().offset(50)
                            make.leftMargin.equalToSuperview().offset(50)
    //            make.centerX.equalTo(bottomView)
    //            make.centerY.equalTo(bottomView)
            }
        }
    @objc private func didTabNextBtn(_ sender: UIButton) {
        let svc = SecondViewController()
        navigationController?.pushViewController(svc, animated: true)
//        svc.modalPresentationStyle = .fullScreen
//        present(svc, animated: true, completion: nil)
    }
    @objc private func didTabNextBtn2(_ sender: UIButton) {
        let tvc = ThirdViewController()
        navigationController?.pushViewController(tvc, animated: true)
    }
}
