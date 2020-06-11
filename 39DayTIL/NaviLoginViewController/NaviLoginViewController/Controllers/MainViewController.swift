//
//  ViewController.swift
//  NaviLoginViewController
//
//  Created by mac on 2020/06/08.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let stackView = UIStackView()
    let imageView = UIImageView()
    let idTextfield = UITextField()
    let passwordTextfield = UITextField()
    let loginBtn = UIButton()
    let signUpBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isHidden = true
        setupUI()
    }
    
    func setupUI() {
        signUpBtn.frame = CGRect(x: view.safeAreaInsets.left + 30 ,
                                 y: view.safeAreaInsets.top + 550,
                                 width: 300,
                                 height: 40)
        signUpBtn.setTitle("계정이 아직 없으신가요? 회원가입", for: .normal)
        signUpBtn.setTitleColor(.blue, for: .normal)
        signUpBtn.addTarget(self, action: #selector(signUpBtnAction(_:)), for: .touchUpInside)
        view.addSubview(signUpBtn)
        
        loginBtn.frame = CGRect(x: view.safeAreaInsets.left + 30,
                                y: view.safeAreaInsets.top + 450,
                                width: 300,
                                height: 40)
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.setTitleColor(.black , for: .normal)
        loginBtn.addTarget(self, action: #selector(loginBtnAction(_:)), for: .touchUpInside)
        view.addSubview(loginBtn)
        
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
        idTextfield.placeholder = "아이디를 입력해 주세요"
        idTextfield.borderStyle = .roundedRect
        idTextfield.backgroundColor = .white
        view.addSubview(idTextfield)
        
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
    @objc private func signUpBtnAction(_ sender: UIButton) {
        print("sign up")
        let rvc = RegisterViewController()
        self.navigationController?.pushViewController(rvc, animated: true)
    }

}

extension MainViewController: UITextFieldDelegate {

}
