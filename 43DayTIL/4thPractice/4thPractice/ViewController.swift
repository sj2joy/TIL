//
//  ViewController.swift
//  4thPractice
//
//  Created by mac on 2020/06/15.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let onOffSwitch = UISwitch()
    let userDefault = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        animalUserDefault()
        setupUI()
    }
    private func animalUserDefault() {
        guard let animal = UserDefaults.standard.value(forKey: "animal") as? String else {
            UserDefaults.standard.setValue("cat", forKey: "animal")
            return
        }
        animal == "dog" ? (onOffSwitch.isOn = true) : (onOffSwitch.isOn = false)
        imageView.image = UIImage(named: animal)
        nameLabel.text = "\(animal)"
    }
    
    private func setupUI() {
        imageView.frame = CGRect(x: view.safeAreaInsets.left + 60,
                                 y: view.safeAreaInsets.top + 50,
                                 width: 250,
                                 height: 200)
        view.addSubview(imageView)
        
        nameLabel.frame = CGRect(x: imageView.frame.minX,
                                 y: imageView.frame.maxY + 50,
                                 width: 250,
                                 height: 70)
        nameLabel.backgroundColor = .yellow
        nameLabel.textAlignment = .center
        nameLabel.textColor = .blue
        nameLabel.font = UIFont(name: "Arial", size: 40)
        view.addSubview(nameLabel)
        
        onOffSwitch.frame = CGRect(x: nameLabel.center.x ,
                                   y: nameLabel.frame.maxY + 100,
                                   width: 50,
                                   height: 50)
        onOffSwitch.addTarget(self, action: #selector(onOff(_:)), for: .touchUpInside)
        view.addSubview(onOffSwitch)
        
    }
    @objc private func onOff(_ sender: UISwitch) {
        if UserDefaults.standard.value(forKey: "animal") as? String != "cat" {
            UserDefaults.standard.set("cat", forKey: "animal")
            onOffSwitch.isOn = false
        } else {
            UserDefaults.standard.set("dog", forKey: "animal")
            onOffSwitch.isOn = true
        }
        imageView.image = UIImage(named: UserDefaults.standard.value(forKey: "animal") as! String)
        nameLabel.text = UserDefaults.standard.value(forKey: "animal") as! String
    }
}

