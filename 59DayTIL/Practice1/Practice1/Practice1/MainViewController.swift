//
//  ViewController.swift
//  Practice1
//
//  Created by mac on 2020/08/19.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let onOffSwitch = UISwitch()
    let intervalStepper = UIStepper()
    let switchLabel = UILabel()
    let emailLabel = UILabel()
    let intervalLabel = UILabel()
    let updateLabel = UILabel()
    let stepperLabel = UILabel()
    let emailTextfield = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "설정"
        setupUI()
    }

    private func setupUI() {
        let nextBtn = UIButton()
        nextBtn.frame = CGRect(x: 50, y: 300, width: 70, height: 40)
        nextBtn.setTitleColor(.black, for: .normal)
        nextBtn.setTitle("다음으로", for: .normal)
        nextBtn.backgroundColor = .yellow
        nextBtn.center = CGPoint(x: self.view.frame.size.width / 2, y: 300)
        nextBtn.addTarget(self, action: #selector(didTabNextBtn(_:)), for: .touchUpInside)
        view.addSubview(nextBtn)
        
       
        emailLabel.text = "Email"
        emailLabel.frame = CGRect(x: 30, y: 100, width: 100, height: 30)
        emailLabel.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(emailLabel)
        
        updateLabel.text = "자동갱신"
        updateLabel.frame = CGRect(x: emailLabel.frame.origin.x, y: 150, width: 100, height: 30)
        updateLabel.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(updateLabel)
        
        intervalLabel.text = "갱신주기"
        intervalLabel.frame = CGRect(x: emailLabel.frame.origin.x, y: 200, width: 100, height: 30)
        intervalLabel.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(intervalLabel)
        
        emailTextfield.frame = CGRect(x: 120, y: 100, width: 220, height: 30)
        emailTextfield.font = UIFont.systemFont(ofSize: 13)
        emailTextfield.borderStyle = .roundedRect
        emailTextfield.placeholder = "예) sj2joy@naver.com"
        emailTextfield.autocapitalizationType = .none
        view.addSubview(emailTextfield)
        
        onOffSwitch.frame = CGRect(x: 120, y: 150, width: 50, height: 30)
        onOffSwitch.setOn(true, animated: true)
        onOffSwitch.addTarget(self, action: #selector(didTabOnOff(_:)), for: .valueChanged)
        view.addSubview(onOffSwitch)
        
        intervalStepper.frame = CGRect(x: 120, y: 200, width: 50, height: 30)
        intervalStepper.minimumValue = 0
        intervalStepper.maximumValue = 100
        intervalStepper.stepValue = 5
        intervalStepper.value = 0
        intervalStepper.addTarget(self, action: #selector(didTabStepper(_:)), for: .valueChanged)
        view.addSubview(intervalStepper)
        
        switchLabel.frame = CGRect(x: 250, y: 150, width: 100, height: 30)
        switchLabel.font = UIFont.systemFont(ofSize: 12)
        switchLabel.textColor = .red
        switchLabel.text = "갱신함"
        view.addSubview(switchLabel)
        
        stepperLabel.frame = CGRect(x: 250, y: 200, width: 100, height: 30)
        stepperLabel.font = UIFont.systemFont(ofSize: 12)
        stepperLabel.textColor = .red
        stepperLabel.text = "0분마다"
        view.addSubview(stepperLabel)

    }
    
    @objc private func didTabOnOff(_ sender: UISwitch) {
        switchLabel.text = sender.isOn == true ? "갱신됨" : "갱신되지 않음"
    }
    @objc private func didTabStepper(_ sender: UIStepper) {
        stepperLabel.text = "\(Int(sender.value))분 마다"
    }
    @objc private func didTabNextBtn(_ sender: UIButton) {
        let readVC = ReadViewController()
        readVC.emailAddress = emailTextfield.text
        readVC.intervalValue = Int(intervalStepper.value)
        readVC.isUpdate = onOffSwitch.isOn
        navigationController?.pushViewController(readVC, animated: true)

    }
}


