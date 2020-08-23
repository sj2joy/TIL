//
//  SideBarViewController.swift
//  MyMemoryUsingStoryboard
//
//  Created by mac on 2020/08/23.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class SideBarViewController: UITableViewController {
    

    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let profileImage = UIImageView()
    
    let titles = [ "새글 작성하기",
                   "친구 새글",
                   "달력으로 보기",
                   "공지사항",
                   "통계",
                   "계정관리",
    ]
    // 아아콘 데이터 배열
    let icons = [
        UIImage(named: "icon01.png"),
        UIImage(named: "icon02.png"),
        UIImage(named: "icon03.png"),
        UIImage(named: "icon04.png"),
        UIImage(named: "icon05.png"),
        UIImage(named: "icon06.png"),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: self.view.frame.width,
                                              height: 70))
        headerView.backgroundColor = UIColor.systemTeal
        self.tableView.tableHeaderView = headerView
        
        self.nameLabel.frame = CGRect(x: 70, y: 15, width: 100, height: 30)
        self.nameLabel.text = "보노보노"
        self.nameLabel.textColor = UIColor.white
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        self.nameLabel.backgroundColor = UIColor.clear
        headerView.addSubview(self.nameLabel)
        
        self.emailLabel.frame = CGRect(x: 70, y: 30, width: 100, height: 30)
        self.emailLabel.text = "sj2joy@naver.com"
        self.emailLabel.textColor = UIColor.white
        self.emailLabel.font = UIFont.systemFont(ofSize: 11)
        self.emailLabel.backgroundColor = UIColor.clear
        headerView.addSubview(self.emailLabel)
        
        let profile = UIImage(named: "account.jpg")
        self.profileImage.image = profile
        self.profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
        self.profileImage.layer.masksToBounds = true
        view.addSubview(self.profileImage)
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return titles.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "menuCell"
        let cell = tableView.dequeueReusableCell(withIdentifier:id) ??
            UITableViewCell(style: .default, reuseIdentifier: id)
        
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize:14)
        return cell
    }
}

