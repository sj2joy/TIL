//
//  ViewController.swift
//  NiceApp
//
//  Created by mac on 2020/06/08.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit
import Lottie

class MainViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Main Screen"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 50)
        return label
    }()
    
    let animationView: AnimationView = {
        let animView = AnimationView(name: "20940-clap-animation-yellow")
        animView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        animView.contentMode = .scaleAspectFill
        return animView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(animationView)
    
        animationView.center = view.center
            //애니메이션실행 + 그 후에 동작메서드들
        animationView.play{ (finish) in
            self.view.backgroundColor = .white
            self.animationView.removeFromSuperview()
            self.view.addSubview(self.titleLabel)
            self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
            self.titleLabel.centerXAnchor.constraint(
                equalTo: self.view.centerXAnchor).isActive = true
            self.titleLabel.centerYAnchor.constraint(
                equalTo: self.view.centerYAnchor).isActive = true
                 
            print("animatino ended")
        }
    }
    
    
}

