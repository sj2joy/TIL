//
//  ProfileVC.swift
//  MyMemoryUsingStoryboard
//
//  Created by mac on 2020/08/23.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileImage = UIImageView()
    let tableView = UITableView()
    let userinfo = UserInfoManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "프로필"
        self.navigationController?.navigationBar.isHidden = true
        setupUI()
        drawBtn()
        let tap = UITapGestureRecognizer(target: self, action: #selector(profile(_ :)))
        self.profileImage.addGestureRecognizer(tap)
        self.profileImage.isUserInteractionEnabled = true
    }
    
    func drawBtn() {
        
        let logoutView = UIView()
        logoutView.frame.size.width = self.view.frame.width
        logoutView.frame.size.height = 40
        logoutView.frame.origin.x = 0
        logoutView.frame.origin.y = self.tableView.frame.origin.y + self.tableView.frame.height
        logoutView.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        self.view.addSubview(logoutView)
        
        let logoutBtn = UIButton(type: . system)
        logoutBtn.frame.size.width = 100
        logoutBtn.frame.size.height = 30
        logoutBtn.center.x = logoutView.frame.size.width / 2
        logoutBtn.center.y = logoutView.frame.size.height / 2
        
        if self.userinfo.isLogin == true {
            logoutBtn.setTitle("로그아웃", for: .normal)
            logoutBtn.addTarget(self, action: #selector(doLogout(_:)), for: .touchUpInside)
        } else {
            logoutBtn.setTitle("로그인", for: .normal)
            logoutBtn.addTarget(self, action: #selector(doLogin(_:)), for: .touchUpInside)
        }
        logoutView.addSubview(logoutBtn)
    }
    private func setupUI() {
        
        let backBtn = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeBtn(_:)))
        navigationItem.leftBarButtonItem = backBtn
        
        let image = self.userinfo.profile
        profileImage.image = image
        profileImage.frame.size = CGSize(width: 100, height: 100)
        profileImage.center = CGPoint(x: self.view.frame.width / 2, y: 270)
        profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
        profileImage.layer.masksToBounds = true
        view.addSubview (profileImage)
        
        let backgroundImage = UIImage(named: "profile-bg")
        let bgImg = UIImageView(image: backgroundImage)
        bgImg.frame.size = CGSize(width: bgImg.frame.size.width,
                                  height: bgImg.frame.size.height)
        bgImg.center = CGPoint(x: self.view.frame.width / 2, y: 40)
        bgImg.layer.cornerRadius = bgImg.frame.size.width / 2
        bgImg.layer.masksToBounds = true
        
        self.view.addSubview(bgImg)
        self.view.bringSubviewToFront(self.tableView)
        self.view.bringSubviewToFront(self.profileImage)
        
        tableView.frame = CGRect(x: 0,
                                 y: self.profileImage.frame.origin.y + self.profileImage.frame.size.height + 20,
                                 width: self.view.frame.width,
                                 height: 100)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview (tableView)
    }
    
    func imgPicker( _ source : UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.sourceType = source
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true)
    }
    @objc private func profile(_ sender: UIButton) {
        guard self.userinfo.accout != nil else {
            self.doLogin(self)
            return
        }
        let alert = UIAlertController(title: nil, message: "사진을 가져올 곳을 선택해주세요.", preferredStyle: .actionSheet)
        //카메라 사용이 가능할 때
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Camera", style: .default) { (_) in
                self.imgPicker(.camera)
            })
        }
        //저장된 앨범을 쓸 수 있을 때
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            alert.addAction(UIAlertAction(title: "Saved Album", style: .default) { (_) in
                self.imgPicker(.savedPhotosAlbum)
            })
        }
        //포토 라이브러리
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alert.addAction(UIAlertAction(title: "Photo Library", style: .default) { (_) in
                self.imgPicker(.photoLibrary)
            })
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @objc private func closeBtn(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @objc private func doLogin(_ sender: Any) {
        let loginAlert = UIAlertController(title: "Login", message: nil, preferredStyle: .alert)
        loginAlert.addTextField { (textfield) in
            textfield.placeholder = "Your Account"
        }
        loginAlert.addTextField { (textfield) in
            textfield.placeholder = "Password"
            textfield.isSecureTextEntry = true
        }
        loginAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        loginAlert.addAction(UIAlertAction(title: "Login", style: .destructive) { (_) in
            let account = loginAlert.textFields?[0].text ?? ""
            let password = loginAlert.textFields?[1].text ?? ""
            
            if self.userinfo.login(account: account, password: password) {
                self.tableView.reloadData()
                self.profileImage.image = self.userinfo.profile
                self.drawBtn()
            } else {
                let message = "로그인에 실패하였습니다."
                let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: false)
            }
        })
        self.present(loginAlert, animated: false)
    }
    
    @objc func doLogout(_ sender: Any) {
        let msg = "로그아웃하시겠습니까?"
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .destructive) { (_) in
            if self.userinfo.logout() {
                self.tableView.reloadData()
                self.profileImage.image = self.userinfo.profile
                self.drawBtn()
            }
        })
        self.present(alert, animated: false)
    }
}
//MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.accessoryType = .disclosureIndicator
        
        switch indexPath.row {
        case 0 :
            cell.textLabel?.text = "이름"
            cell.detailTextLabel?.text = self.userinfo.name ?? "Login Please"
        case 1 :
            cell.textLabel?.text = "계정"
            cell.detailTextLabel?.text = self.userinfo.accout ?? "Login Please"
        default :
            ()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.userinfo.isLogin == false {
            self.doLogin(self.tableView)
            print("Asdfasdf")
        }
    }
}

//MARK: - UITableViewDelgate
extension ProfileViewController: UITableViewDelegate {
    
}
//MARK: - UINavigationControllerDelegate
extension ProfileViewController: UINavigationControllerDelegate {
    
}
//MARK: - UIImagePickerControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.userinfo.profile = img
            self.profileImage.image = img
        }
        picker.dismiss(animated: true)
    }
}
