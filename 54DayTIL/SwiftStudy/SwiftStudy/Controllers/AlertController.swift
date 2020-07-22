//
//  AlertController.swift
//  SwiftStudy
//
//  Created by mac on 2020/07/20.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class AlertController: UIViewController {
    
    override var description: String { "Practice 2 - AlertController" }
    
    var number = 0
    let label = UILabel()
    let countButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "AlertController"
        setupUI()
    }
    
    private func setupUI() {
        label.frame = CGRect(x: view.center.x,
                             y: view.frame.maxY,
                             width: 300,
                             height: 100)
        label.center = view.center
        label.font = UIFont.systemFont(ofSize: 100)
        label.textAlignment = .center
        label.text = "\(number)"
        view.addSubview(label)
        
        countButton.frame = CGRect(x: 40,
                                   y: label.frame.maxY + 100,
                                 width: 300,
                                 height: 70)
        countButton.setTitle("Count", for: .normal)
        countButton.titleLabel?.font = UIFont.systemFont(ofSize: 50)
        countButton.backgroundColor = .blue
        countButton.addTarget(self, action: #selector((didTabBtn(_:))), for: .touchUpInside)
        view.addSubview(countButton)
        
    }
    @objc private func didTabBtn(_ button : UIButton) {
        let alertController = UIAlertController(title: "Title", message: "숫자를 입력해주세요", preferredStyle: .alert)
        alertController.addTextField { (action) in
            action.placeholder = "숫자를 입력해 주세요"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            var addNumber = 0
            
            if let textfield = alertController.textFields?.first,
                let inputNumber = textfield.text,
                let number = Int(inputNumber) {
                addNumber = number
            }
            self.number += addNumber
            self.label.text = "\(self.number)"
        }
        let subtractAction = UIAlertAction(title: "Subtract", style: .default) { (action) in
            var subtractNumber = 0
            
            if let textfield = alertController.textFields?.first,
                let inputNumber = textfield.text,
                let number = Int(inputNumber) {
                subtractNumber = number
            }
            self.number -= subtractNumber
            self.label.text = "\(self.number)"
        }
        let resetAction = UIAlertAction(title: "Reset", style: .default) { (action) in
            self.number = 0
            self.label.text = "\(self.number)"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        alertController.addAction(addAction)
        alertController.addAction(subtractAction)
        alertController.addAction(resetAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }
}
