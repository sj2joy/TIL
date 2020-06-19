//
//  SectionViewController.swift
//  10thPractice
//
//  Created by mac on 2020/06/18.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class SectionViewController: UIViewController {
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationSet()
        configure()
        autoLayout()
    }
    private func navigationSet() {
        title = "Domino's"
    }
    private func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    private func autoLayout() {
        let guide = view.safeAreaLayoutGuide
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
    }
}

extension SectionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuData[section].products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let reusableCell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell = reusableCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        let product = menuData[indexPath.section].products[indexPath.row]
        cell.imageView?.image = UIImage(named: product.name)
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = String(product.price) + "원"
        cell.selectionStyle = .none
        return cell
    }
}

extension SectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = menuData[indexPath.section].products[indexPath.row].name
        let detailVC = DetailViewController(productName : name)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIImageView()
        headerView.backgroundColor = .white
        headerView.image = UIImage(named: menuData[section].category)
        headerView.contentMode = .scaleAspectFit
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }}


