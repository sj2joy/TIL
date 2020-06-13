//
//  CreatePostViewController.swift
//  SimpleBlog
//
//  Created by mac on 2020/06/12.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit
import Alamofire

class CreatePostViewController: UIViewController {
    
    
    @IBOutlet weak var titleInput: UITextField!
    
    @IBOutlet weak var bodyInput: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleInput.delegate = self
        bodyInput.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "등록하기", style: .plain, target: self, action: #selector(registerPost))
    }
    @objc private func registerPost() {
        print("register post selected")
        print("입력된 타이틀: \(titleInput.text ?? "")")
        print("입력된 본문: \(bodyInput.text ?? "")")
        
        let parameters: [String: Any] = [
            "title" : (titleInput.text ?? "") as String,
            "body" : (bodyInput.text ?? "") as String,
        ]
        
        AF.request("http://13.209.73.176/api/post",
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default).responseJSON{ (response) in
                    print("응답여부: \(response)")
                    self.navigationController?.popViewController(animated: true)
        }
    }
}
//MARK: - Delegate

extension CreatePostViewController: UITextViewDelegate, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \(textField.text)")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing: \(textField.text)")
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(textField.text)
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("textViewDidBeginEditing: \(textView.text)")
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        print("textViewDidEndEditing: \(textView.text)")
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print(textView.text)
        return true
    }
}
