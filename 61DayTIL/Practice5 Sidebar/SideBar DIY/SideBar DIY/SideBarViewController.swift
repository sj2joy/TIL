//
//  SideBarViewController.swift
//  SideBar DIY
//
//  Created by mac on 2020/08/22.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class SideBarViewController: UITableViewController {
    
    let titles = [
    "메뉴 01",
    "메뉴 02",
    "메뉴 03",
    "메뉴 04",
    "메뉴 05",
    ]
    // 메뉴 아이콘 배열
    let icons = [
        UIImage(named: "icon01.png"),
        UIImage(named: "icon02.png"),
        UIImage(named: "icon03.png"),
        UIImage(named: "icon04.png"),
        UIImage(named: "icon05.png"),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        let accountLabel = UILabel()
        accountLabel.frame = CGRect(x:10, y:30, width: view.frame.width, height: 30)
        accountLabel.text = "sj2joy@naver.com"
        accountLabel.textColor = UIColor.white
        accountLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        // 테이블 뷰 상단에 표시될 뷰를 정의
        let view = UIView()
        view.frame = CGRect(x:0, y:0, width: view.frame.width, height:70)
        view.backgroundColor = UIColor.brown
        view.addSubview(accountLabel)
        // 생성한뷰를 테이블헤더뷰영역에 등록
        self.tableView.tableHeaderView = view
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "menuCell"
        
        //let cell = UITableViewCell() <----- 이렇게만 쓰면 재사용셀이 아니라 매번 새로만드는
        
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? //재사용셀 사용할 때
            UITableViewCell(style: .default, reuseIdentifier: id)
                
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return cell
    }
}
