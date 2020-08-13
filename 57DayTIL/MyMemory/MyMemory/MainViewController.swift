//
//  ViewController.swift
//  MyMemory
//
//  Created by mac on 2020/08/13.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List"
        setupUI()
    }
    let font = UIFont.systemFont(ofSize: 30)
    
    private func setupUI() {
        let barButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(didTabNextButton(_:)))
        barButtonItem.setTitleTextAttributes([NSAttributedString.Key.font: font],
                                             for: .normal)
        navigationItem.rightBarButtonItem = barButtonItem
        
        tableView.frame = view.frame
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    @objc private func didTabNextButton(_ sender: UIBarButtonItem) {
        let memoWriteVC = MemoWriteViewContrller()
        navigationController?.pushViewController(memoWriteVC, animated: true)
        
    }
}
//MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if indexPath.row % 2 == 0 {
            // 셀 재사용 시도 후 없으면 생성
            cell = tableView.dequeueReusableCell(withIdentifier: "memoCell")
                ?? UITableViewCell(style: .default, reuseIdentifier: "memoCell")
            cell.accessoryType = .disclosureIndicator
            
            let titleLabel = UILabel()
            titleLabel.frame = CGRect(x: 30, y: 10, width: 80, height: 20)
            titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            titleLabel.backgroundColor = .yellow
            titleLabel.text = "글의 제목"
            cell.addSubview(titleLabel)
            
            let contentLabel = UILabel()
            contentLabel.frame = CGRect(x: 30, y: titleLabel.frame.maxY + 20, width: 80, height: 20)
            contentLabel.backgroundColor = .lightGray
            contentLabel.text = "글의 내용"
            cell.addSubview(contentLabel)
            
            let dateLabel = UILabel()
            dateLabel.frame = CGRect(x: titleLabel.frame.maxX + 110, y: cell.center.y, width: 110, height: 30)
            dateLabel.numberOfLines = 2
            dateLabel.textAlignment = .center
            dateLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
            dateLabel.lineBreakMode = .byWordWrapping
            cell.addSubview(dateLabel)
            
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "memoCellWithImage")
                ?? UITableViewCell(style: .default, reuseIdentifier: "memoCellWithImage")
            cell.accessoryType = .disclosureIndicator
            
            let imgView = UIImageView()
            imgView.frame = CGRect(x: 30, y: 10, width: 60, height: 60)
            imgView.backgroundColor = .black
            cell.addSubview(imgView)
            
            let titleLabel = UILabel()
            titleLabel.frame = CGRect(x: imgView.frame.maxX + 10, y: 10, width: 80, height: 20)
            titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            titleLabel.backgroundColor = .yellow
            titleLabel.text = "글의 제목"
            cell.addSubview(titleLabel)
            
            let contentLabel = UILabel()
            contentLabel.frame = CGRect(x: imgView.frame.maxX + 10, y: titleLabel.frame.maxY + 20, width: 80, height: 20)
            contentLabel.backgroundColor = .lightGray
            contentLabel.text = "글의 내용"
            cell.addSubview(contentLabel)
            
            let dateLabel = UILabel()
            dateLabel.frame = CGRect(x: titleLabel.frame.maxX + 40, y: cell.center.y, width: 110, height: 30)
            dateLabel.numberOfLines = 2
            dateLabel.textAlignment = .center
            dateLabel.text = "yyyy-mm-dd"
            dateLabel.lineBreakMode = .byWordWrapping
            dateLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
            cell.addSubview(dateLabel)
        }
        return cell
    }
}
//MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let preViewVC = PreViewController()
        navigationController?.pushViewController(preViewVC, animated: true)
    }
}
