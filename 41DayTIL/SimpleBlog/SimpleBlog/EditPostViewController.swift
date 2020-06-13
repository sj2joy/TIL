//
//  EditPostViewController.swift
//  SimpleBlog
//
//  Created by mac on 2020/06/12.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit
import Alamofire

class EditPostViewController: UIViewController {
    
    @IBOutlet weak var titleInput: UITextField!
    
    @IBOutlet weak var bodyInput: UITextView!
    
    var delegate: EditPostViewControllerDelegate?
    
    var receivedPost: Post?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("editVC viewDidLoad 호출됨: \(receivedPost?.id)")
        titleInput.delegate = self
        bodyInput.delegate = self
        navigationItem.title = "포스팅 수정하기"
        
        titleInput.text = receivedPost?.title
        bodyInput.text = receivedPost?.body
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정완료", style: .plain, target: self, action: #selector(editCompleted))
    }
    @objc private func editCompleted() {
        print("수정완료")
        print("입력된 타이틀: \(titleInput.text ?? "")")
        print("입력된 본문: \(bodyInput.text ?? "")")
        
        let parameters: [String: Any] = [
            "title" : (titleInput.text ?? "") as String,
            "body" : (bodyInput.text ?? "") as String,
        ]
        
        AF.request("http://13.209.73.176/api/post/\(receivedPost?.id ?? "")",
            method: .put,
            parameters: parameters,
            encoding: JSONEncoding.default).responseJSON{ (response) in
                print("응답여부: \(response)")
                if let value = response.value as? [String: AnyObject]  {
                    //                print(value)
                    print(value["id"] as AnyObject) // value = api에서 호출한 전체
                    print(value["title"] as AnyObject)
                    print(value["body"] as AnyObject)
                    
                    if let dict = value as? NSDictionary {
                        
                        guard let id = dict.value(forKey: "id") else { return }
                        guard let title = dict.value(forKey: "title") else { return }
                        guard let body = dict.value(forKey: "body") else { return }
                        print("파싱된 \(id), \(title), \(body)")
                    
                    let reponsePostItem = Post(id: "\(id)", title: title as! String, body: body as! String)
                    self.delegate?.editPostCompleted(editedPostItem: reponsePostItem)
            }
        }
    }
    self.navigationController?.popViewController(animated: true)
    }
}


//MARK: - Delegate

extension EditPostViewController: UITextViewDelegate, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \(textField.text ?? "")")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing: \(textField.text ?? "")")
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(textField.text ?? "")
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("textViewDidBeginEditing: \(textView.text ?? "")")
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        print("textViewDidEndEditing: \(textView.text ?? "")")
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print(textView.text ?? "")
        return true
    }
}
