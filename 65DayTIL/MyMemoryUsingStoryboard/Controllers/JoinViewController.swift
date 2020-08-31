//
//  JoinViewController.swift
//  MyMemoryUsingStoryboard
//
//  Created by mac on 2020/08/29.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit
import Alamofire

class JoinViewController: UIViewController {
    
    var fieldAccount = UITextField()
    var fieldPassword = UITextField()
    var fieldName = UITextField()
    
    @IBOutlet weak var profile: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func summit(_ sender: UIBarButtonItem) {
        let profile = self.profile.image!.pngData()?.base64EncodedString()
        let param: Parameters = [
            "account" : self.fieldAccount.text!,
            "password": self.fieldPassword.text!,
            "name" : self.fieldName.text!,
            "profile_image": profile!
        ]
        let url = "http://swiftapi.rubypaper.co.kr:2029/userAccount/join"
        let call = AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default)
    
//        call.responseJSON { res in
//            guard let jsonObject = res.result.value as? [String: Any] else {
//                self.alert("asdf")
//                return
//            }
//        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.profile.layer.cornerRadius = self.profile.frame.width / 2
        self.profile.layer.masksToBounds = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedProfile(_:)))
        self.profile.addGestureRecognizer(gesture)
    }
    @objc func tappedProfile(_ sender: UITapGestureRecognizer) {
        let message = "프로필 이미지를 가져올 곳을 선택하세요."
        let sheet = UIAlertController(title: message, message: nil, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        sheet.addAction(UIAlertAction(title: "저장된 앨범", style: .default) { (_) in
            selectLibrary(src: .savedPhotosAlbum)
        })
        sheet.addAction(UIAlertAction(title: "포토 라이브러리", style: .default) { (_) in
            selectLibrary(src: .photoLibrary)
        })
        sheet.addAction(UIAlertAction(title: "카메라", style: .default) { (_) in
            selectLibrary(src: .camera)
        })
        self.present(sheet, animated: false)
        
        func selectLibrary(src: UIImagePickerController.SourceType) {
            if UIImagePickerController.isSourceTypeAvailable(src) {
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.allowsEditing = true
                
                self.present(picker, animated: false)
            } else {
                self.alert("사용할 수 없는 타입입니다.")
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension JoinViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let textfieldFrame = CGRect(x: 20, y: 0, width: cell.bounds.width - 20, height: 37)
        
        switch indexPath.row {
            
        case 0 :
            self.fieldAccount = UITextField(frame: textfieldFrame)
            self.fieldAccount.placeholder = "계정(이메일)"
            self.fieldAccount.borderStyle = .none
            self.fieldAccount.autocapitalizationType = .none
            self.fieldAccount.font = UIFont.systemFont(ofSize: 14)
            cell.addSubview(self.fieldAccount)
        case 1 :
            self.fieldPassword = UITextField(frame: textfieldFrame)
            self.fieldPassword.placeholder = " 비밀번호"
            self.fieldPassword.borderStyle = . none
            self.fieldPassword.isSecureTextEntry = true
            self.fieldPassword.font = UIFont.systemFont(ofSize: 14)
            cell.addSubview(self.fieldPassword)
        case 2 :
            self.fieldName = UITextField(frame: textfieldFrame)
            self.fieldName.placeholder = "이름"
            self.fieldName.borderStyle = .none
            self.fieldName.font = UIFont.systemFont(ofSize: 14)
            cell.addSubview (self.fieldName)
        default :
            ()
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}


//MARK: - UITableViewDelegate

extension JoinViewController: UITableViewDelegate {
    
}

//MARK: - UIImagePickerDelegate
extension JoinViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profile.image = img
        }
        self.dismiss(animated: true)
    }
}
//MARK: - UINavigationControllerDelegate

extension JoinViewController: UINavigationControllerDelegate {
    
}
