//
//  MemoListTableViewController.swift
//  MyMemoryUsingStoryboard
//
//  Created by mac on 2020/08/18.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class MemoListTableViewController: UITableViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let ud = UserDefaults.standard
        if ud.bool(forKey: UserInfoKey.tutorial) == false {
            let vc = self.instanceTutorialVC(name: "MasterVC")
            self.present(vc, animated: false)
            return
        }
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let revealVC = revealViewController() {
            // 바 버튼 아이템 객체를 정의
            let barBtn = UIBarButtonItem()
            barBtn.image = UIImage(named: "sidemenu.png")
            barBtn.target = revealVC // 버튼 클릭 시 호출할 메소드가 정의된 객체를 지정
            barBtn.action = #selector(revealVC.revealToggle(_:)) // 버튼 클릭 시 revealToggle(_:) 호출
            //정의된 바 버튼올 내비게이션 바의 왼쪽 아이템으로 등록
            self.navigationItem.leftBarButtonItem = barBtn
            // 제스처 객체를 뷰에 추가한다.
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer( ))
        }
    }


// MARK: - Table view data source
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let count = self.appDelegate.memoList.count
    return count
}
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let row = self.appDelegate.memoList[indexPath.row]
    let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! MemoCell
    
    cell.subject?.text = row.title
    cell.contents?.text = row.contents
    cell.img?.image = row.image
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    cell.regdate?.text = formatter.string(from: row.regdate!)
    
    return cell
}
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let row = self.appDelegate.memoList[indexPath.row]
    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadViewController else { return }
    vc.param = row
    self.navigationController?.pushViewController(vc, animated: true)
}
}

