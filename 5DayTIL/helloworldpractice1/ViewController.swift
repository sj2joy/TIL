//
//  ViewController.swift
//  helloworldpractice1
//
//  Created by mac on 2019/11/21.
//  Copyright © 2019 Seokjin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let redView = UIView()
    let blueView = UIView()
    let greenView = UIView()
    let label = UILabel()
    let button = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(type: .system)
        button.setTitle("Button", for: .normal)
        button.frame = CGRect(x: 240, y: 700, width: 100, height: 70)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(didTapBtn), for: .touchUpInside)
        view.addSubview(button)
        setupUI()
   
    }
    func setupUI() {
        redView.frame = CGRect(x: 100, y: 100, width: 250, height: 150)
        redView.backgroundColor = .red
        view.addSubview(redView)
        blueView.frame = CGRect(x: 100, y: 300, width: 250, height: 150)
        blueView.backgroundColor = .blue
        view.addSubview(blueView)
        greenView.frame = CGRect(x: 100, y: 500, width: 250, height: 150)
        greenView.backgroundColor = .green
        view.addSubview(greenView)
        label.frame = CGRect(x: 120, y: 700, width: 120, height: 70)
        label.text = "안녕하세요"
        label.textAlignment = .center
        view.addSubview(label)
  
    }
    var toggle = true
    @objc private func didTapBtn(_ sender: UIButton) {
        if toggle == true {
        redView.backgroundColor = .blue
        blueView.backgroundColor = .green
        greenView.backgroundColor = .red
        } else {
            redView.backgroundColor = .red
            blueView.backgroundColor = .blue
            greenView.backgroundColor = .green
        }
        toggle.toggle()
        print("Hi")
    }
}
