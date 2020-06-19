//
//  ViewController.swift
//  9thPractice
//
//  Created by mac on 2020/06/18.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let redView = UIView()
    let blueView = UIView()
    let clickBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        redView.frame = CGRect(x: view.safeAreaInsets.left + 30,
                               y: view.safeAreaInsets.top + 30,
                               width: 70,
                               height: 70)
        redView.backgroundColor = .red
        view.addSubview(redView)
        
        blueView.frame = CGRect(x: view.safeAreaInsets.left + 260,
                                y: view.safeAreaInsets.top + 30,
                                width: 70,
                                height: 70)
        blueView.backgroundColor = .blue
        view.addSubview(blueView)
        
        clickBtn.frame = CGRect(x: view.center.x,
                                y: view.center.y,
                                width: 70,
                                height: 70)
        clickBtn.setTitle("Button", for: .normal)
        clickBtn.setTitleColor(.black, for: .normal)
        clickBtn.addTarget(self, action: #selector(clickedBtn), for: .touchUpInside)
        view.addSubview(clickBtn)
    }
    var toggle = true
    @objc private func clickedBtn() {
        print("Clicked")
        let redViewInitFrame = redView.frame
        let blueViewInitFrame = blueView.frame
        UIView.animateKeyframes(withDuration: 5, delay: 0, animations: {
            if self.toggle {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                    self.redView.center.x += 50
                    self.redView.center.y += 150
                    self.blueView.center.x += 50
                    self.blueView.center.y += 150
                }
                UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25){
                    self.redView.frame = redViewInitFrame
                    self.blueView.frame = blueViewInitFrame
                }
            }
            self.toggle.toggle()

        }
        )}
}
