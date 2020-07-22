//
//  Login.swift
//  SwiftStudy
//
//  Created by mac on 2020/07/20.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    struct Key {
        static let isSignIn = "IsSignIn"
        static let userId = ""
    }
    
    override var description: String { "Practice 3 - LoginViewController" }
    
    let userId = "sj2joy"
    let userPassword = "sj2joy"
    let mainView = UIView()
    let logoImageView = UIImageView(image: UIImage(named: "fastcampus_logo"))
    let userImage = UIImageView(image: UIImage(named: "user"))
    let idTextField = UITextField()
    let passwordImage = UIImageView(image: UIImage(named: "password"))
    let passwordTextField = UITextField()
    let signInButton = UIButton()
    var isSignIn: Bool {
        UserDefaults.standard.bool(forKey: Key.isSignIn)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        signInButton.isHidden = true
        
        idTextField.resignFirstResponder()
        setupUI()
        setUIConstraint()
    }
    
    private func setupUI() {
        mainView.backgroundColor = .clear
        userImage.contentMode = .scaleAspectFit
        passwordImage.contentMode = .scaleAspectFit
        idTextField.borderStyle = .line
        passwordTextField.borderStyle = .line
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.addTarget(self, action: #selector(didTabNextButton(_:)), for: .touchUpInside)
        signInButton.backgroundColor = .darkGray
        
        view.addSubview(logoImageView)
        view.addSubview(mainView)
        mainView.addSubview(signInButton)
        mainView.addSubview(idTextField)
        mainView.addSubview(userImage)
        mainView.addSubview(passwordTextField)
        mainView.addSubview(passwordImage)
    }
    
    private func setUIConstraint() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150).isActive = true
        logoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100).isActive = true
        logoImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100).isActive = true
        logoImageView.bottomAnchor.constraint(equalTo: mainView.topAnchor, constant: -180).isActive = true
        
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20).isActive = true
        userImage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20).isActive = true
        userImage.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -180).isActive = true
        
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        idTextField.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20).isActive = true
        idTextField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 80).isActive = true
        idTextField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -40).isActive = true
        
        passwordImage.translatesAutoresizingMaskIntoConstraints = false
        passwordImage.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 40).isActive = true
        passwordImage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 22).isActive = true
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 40).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 80).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -40).isActive = true
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 180).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.topAnchor.constraint(equalTo: passwordImage.bottomAnchor, constant: 40).isActive = true
        signInButton.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 40).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20).isActive = true
        signInButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10).isActive = true
    }
    @objc private func didTabNextButton(_ sender: Any) {
        print("Button Clicked")
        guard let userID = idTextField.text,
            let password = passwordTextField.text
            else { return }
        let isAuthenticated = (userID == self.userId && password == self.userPassword)
        if isAuthenticated {
            let loginVC = AfterLoginViewController()
            idTextField.text?.removeAll()
            passwordTextField.text?.removeAll()
            navigationController?.pushViewController(loginVC, animated: true)
            print("Success")
        }else {
            print("Failed")
        }
    }
}

//MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.mainView.frame.origin.y -= 100
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.mainView.frame.origin.y += 100
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didTabNextButton(textField)
        textField.resignFirstResponder()
        return true
    }
}
