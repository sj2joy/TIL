//
//  ViewController.swift
//  3rdPractice
//
//  Created by mac on 2020/06/15.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let alertBtn = UIButton()
    let countLbl = UILabel()
    var count: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        alertBtn.setTitle("Click", for: .normal)
        alertBtn.setTitleColor(.black, for: .normal)
        alertBtn.frame = CGRect(x: view.center.x - 80,
                                y: view.center.y - 50,
                                width: 150,
                                height: 150)
        alertBtn.backgroundColor = .yellow
        alertBtn.addTarget(self, action: #selector(didTabBtn(_:)), for: .touchUpInside)
        view.addSubview(alertBtn)
        
        countLbl.text = "\(count)"
        countLbl.frame = CGRect(x: alertBtn.frame.minX - 20,
                                y: alertBtn.frame.minY - 150,
                                width: 200,
                                height: 40)
        countLbl.textAlignment = .center
        countLbl.font = UIFont(name: "Arial", size: 30)
        view.addSubview(countLbl)
        
    }
    @objc private func didTabBtn(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Title", message: "숫자입력", preferredStyle: .alert)
        alertController.addTextField { (action) in
            action.placeholder = "숫자를 입력해주세요"
        }
        
        let addAction = UIAlertAction(title: "더하기", style: .default) { (action) in
            var addNumber = 0
            
            if let textField = alertController.textFields?.first,
                let inputNumber = textField.text,
                let count = Int(inputNumber) {
                addNumber = count
            }
            self.count += addNumber
            self.countLbl.text = "\(self.count)"
            if self.count >= 0 {
                self.countLbl.textColor = .blue
            }else {
                self.countLbl.textColor = .red
            }
        }
        let minusAction = UIAlertAction(title: "빼기", style: .default) { (action) in
            var minusNumber = 0
            
            if let textField = alertController.textFields?.first,
                let inputNumber = textField.text,
                let count = Int(inputNumber) {
                minusNumber = count
            }
            self.count -= minusNumber
            self.countLbl.text = "\(self.count)"
        }
        let resetAction = UIAlertAction(title: "리셋", style: .default) { (aciton) in
            self.count = 0
            self.countLbl.text = "\(self.count)"
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
            
        }
        alertController.addAction(addAction)
        alertController.addAction(minusAction)
        alertController.addAction(resetAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}


