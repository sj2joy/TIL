//
//  ViewController.swift
//  5thPractice
//
//  Created by mac on 2020/06/16.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let imageView = UIImageView()
    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        setupUI()
    }
    
    private func setupUI() {
        imageView.frame = CGRect(x: view.safeAreaInsets.left + 60,
                                 y: view.safeAreaInsets.top + 50,
                                 width: 250,
                                 height: 200)
        view.addSubview(imageView)
        
        textField.placeholder = "이름을 입력해주세요"
        textField.textAlignment = .center
        textField.frame = CGRect(x: imageView.frame.minX,
                                 y: imageView.frame.maxY + 50,
                                 width: imageView.frame.width,
                                 height: 50)
        view.addSubview(textField)
    }
    
}
//MARK: - TextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "cat" {
            imageView.image = UIImage(named: "cat")
        } else if textField.text == "dog" {
            imageView.image = UIImage(named: "dog")
        } else {
            imageView.backgroundColor = .black
        }
    }
}
