//
//  ViewController.swift
//  SwiftStudy
//
//  Created by mac on 2020/07/20.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let tableView = UITableView()
    var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"
        
        tableView.frame = view.frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reusableCell")
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewControllers = [
            FrameBounds(),
            AlertController(),
            LoginViewController(),
            CalculatorViewController(),
            MapViewController(),
            ScrollViewContrller(),
        ]
    }
}

//MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath)
        cell.textLabel?.text = "\(viewControllers[indexPath.row])"
        return cell
    }
}
//MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainVC = viewControllers[indexPath.row]
        navigationController?.pushViewController(mainVC, animated: true)
    }
}
