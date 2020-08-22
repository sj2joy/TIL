//
//  ViewController.swift
//  Practice3
//
//  Created by mac on 2020/08/21.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = .systemTeal
        initTitleNew()
    }
    func initTitleNew() {
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: 200, height: 36)
        
        let topTitle = UILabel()
        topTitle.frame = CGRect(x: 0, y: 0, width: 200, height: 18)
        topTitle.numberOfLines = 1
        topTitle.textAlignment = .center
        topTitle.font = UIFont.systemFont(ofSize: 15)
        topTitle.textColor = UIColor.white
        topTitle.text = "58개 숙소"
        
        let subTitle = UILabel()
        subTitle.frame = CGRect(x: 0, y: 18, width: 200, height: 18)
        subTitle.numberOfLines = 1
        subTitle.textAlignment = .center
        subTitle.font = UIFont.systemFont(ofSize: 12)
        subTitle.textColor = UIColor.white
        subTitle.text = "1박(1월 10일 ~ 1월 11일)"
        // © 상호레이블을 컨테이너 뷰에 추가한다.
        containerView.addSubview(topTitle)
        containerView.addSubview(subTitle)
        
        navigationItem.titleView = containerView
        let color = UIColor(red:0.02, green:0.22, blue:0.49, alpha:1.0)
        navigationController?.navigationBar.barTintColor = color
        
        let defaultAlertBtn = UIButton(type: .system)
        defaultAlertBtn.frame = CGRect(x: 0, y: 100, width: 100, height: 30)
        defaultAlertBtn.center.x = self.view.frame.width / 2
        defaultAlertBtn.setTitle("기본 알림창", for: .normal)
        defaultAlertBtn.addTarget(self, action: #selector(defaultAlert(_:)), for: .touchUpInside)
        view.addSubview(defaultAlertBtn)
        
        let nextBtn = UIButton(type: .system)
        nextBtn.frame = CGRect(x: 0, y:  150, width: 100, height: 30)
        nextBtn.center.x = view.frame.width / 2
        nextBtn.setTitle("다음으로", for: .normal)
        nextBtn.addTarget(self, action: #selector(didTabNextBtn(_:)), for: .touchUpInside)
        view.addSubview(nextBtn)
    }
    @objc private func didTabNextBtn(_ sender: UIButton) {
        let mapVC = MapAlertViewController()
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    @objc private func defaultAlert(_ sender: UIButton) {
        let viewC = UIViewController()
        viewC.view.backgroundColor = .red
        
        let alert = UIAlertController(title: "알림창",
                                      message: "가본 메시지가 들어가는 곳",
                                      preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        alert.setValue(viewC, forKey: "contentViewController")
        
        present(alert, animated: false)
    }
}

