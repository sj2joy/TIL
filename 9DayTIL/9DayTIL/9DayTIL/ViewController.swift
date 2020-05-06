//
//  ViewController.swift
//  9DayTIL
//
//  Created by mac on 2020/05/06.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard
    let onOffSwitch = UISwitch()
    let label = UILabel()
    let image = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        setupUI()
        guard let animal = UserDefaults.standard.value(forKey: "animal") as? String else {
            UserDefaults.standard.setValue("cat", forKey: "animal")
            return
        }
        animal == "dog" ? (onOffSwitch.isOn = true) : (onOffSwitch.isOn = false)
        image.image = UIImage(named: animal)
        label.text = animal
    }
    func setupUI() {
        
        label.frame = CGRect(x: 150, y: 400, width: 100, height: 100)
        label.font = UIFont(name: "Arial", size: 40)
        label.textAlignment = .center
        label.backgroundColor = .yellow
        label.textColor = .blue
        view.addSubview(label)
        
        onOffSwitch.frame = CGRect(x: 180 , y: label.frame.maxY + 100, width: 50, height: 50)
        onOffSwitch.addTarget(self, action: #selector(onOff(_:)), for: .touchUpInside)
        view.addSubview(onOffSwitch)
        
        image.frame = CGRect(x: 50, y: 50, width: 300, height: 200)
        view.addSubview(image)
    }
    
    @objc func onOff(_ sender: UISwitch) {
        if UserDefaults.standard.value(forKey: "animal") as! String != "cat"{
            UserDefaults.standard.set("cat" , forKey: "animal")
            onOffSwitch.isOn = false
                    }else {
            UserDefaults.standard.set("dog" , forKey: "animal")
            onOffSwitch.isOn = true
        }
            image.image = UIImage(named: UserDefaults.standard.value(forKey: "animal") as! String)
            label.text = UserDefaults.standard.value(forKey: "animal") as? String
    }
    
}


