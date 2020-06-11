//
//  RegisterViewController.swift
//  NaviLoginViewController
//
//  Created by mac on 2020/06/08.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let stackView = UIStackView()
     let imageView = UIImageView()
     let idTextfield = UITextField()
     let passwordTextfield = UITextField()
    let emailTextfield = UITextField()
     let returnHome = UIButton()
     let signUpBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    func setupUI() {
        returnHome.frame = CGRect(x: view.safeAreaInsets.left + 30 ,
                                 y: view.safeAreaInsets.top + 550,
                                 width: 300,
                                 height: 40)
        returnHome.setTitle("이미 계정이 있으신가요? 로그인 페이지로", for: .normal)
        returnHome.setTitleColor(.blue, for: .normal)
        returnHome.addTarget(self, action: #selector(returnHomeBtn(_:)), for: .touchUpInside)
        view.addSubview(returnHome)
        
        signUpBtn.frame = CGRect(x: view.safeAreaInsets.left + 30,
                                y: view.safeAreaInsets.top + 490,
                                width: 300,
                                height: 40)
        signUpBtn.setTitle("회원가입", for: .normal)
        signUpBtn.setTitleColor(.black , for: .normal)
        signUpBtn.addTarget(self, action: #selector(loginBtnAction(_:)), for: .touchUpInside)
        view.addSubview(signUpBtn)
        
        passwordTextfield.frame = CGRect(x: view.safeAreaInsets.left + 30,
                                         y: view.safeAreaInsets.top + 370,
                                         width: 300,
                                         height: 40)
        passwordTextfield.placeholder = "비밀번호를 입력해 주세요"
        passwordTextfield.borderStyle = .roundedRect
        passwordTextfield.backgroundColor = .white
        view.addSubview(passwordTextfield)
        
        idTextfield.frame = CGRect(x: view.safeAreaInsets.left + 30,
                                   y: view.safeAreaInsets.top + 300,
                                   width: 300,
                                   height: 40)
        idTextfield.placeholder = "닉네임을 입력해 주세요"
        idTextfield.borderStyle = .roundedRect
        idTextfield.backgroundColor = .white
        view.addSubview(idTextfield)
        
        emailTextfield.frame = CGRect(x: view.safeAreaInsets.left + 30,
                                      y: view.safeAreaInsets.top + 440,
                                      width: 300,
                                      height: 40)
        emailTextfield.placeholder = "이메일을 입력해 주세요"
        emailTextfield.borderStyle = .roundedRect
        emailTextfield.backgroundColor = .white
        view.addSubview(emailTextfield)
        
        imageView.image = UIImage(named: "고양이")
        imageView.frame = CGRect(x: view.safeAreaInsets.left + 90,
                                 y: view.safeAreaInsets.top + 100,
                                 width: 200,
                                 height: 150)
        view.addSubview(imageView)
        
    }
    
    @objc private func loginBtnAction(_ sender: UIButton) {
        print("clicked")
    }
    @objc private func returnHomeBtn(_ sender: UIButton) {
        print("return to Home")
        self.navigationController?.popViewController(animated: true)
    }
}
