//
//  ViewController.swift
//  SimpleBlog
//
//  Created by mac on 2020/06/10.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    //포스팅배열 초기화
    var posts = [Post]()
    
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //데이터 가져오기
        fetchData()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
//MARK: - refreshControl
    @objc private func handleRefresh() {
        posts.removeAll()
        fetchData()
        print("호출됨")
    }
    
//MARK: - private method
    private func fetchData() {
        
        //컴플레션 블락
        AF.request("http://13.209.73.176/api/post/").responseJSON { response in
            //            print(response)
            //            print(response.result)
            
            if let value = response.value as? [String: AnyObject]  {
                //                print(value)
                print(value["data"]) // value = api에서 호출한 전체
                if let array = value["data"] as? NSArray { //data = key값
                    print(array.count)
                    for obj in array {
                        if let dict = obj as? NSDictionary {
                            // Now reference the data you need using:
                            let title = dict.value(forKey: "title")
                            let body = dict.value(forKey: "body")
                            
                            //옵셔널 제거하는 방법 1. guard let
                            //guard let title = dict.value(forKey: "title") else { return }
                            //print("title: \(title)")
                            
                            //방법 2. 옵셔널바인딩. ??
                            print("title: \(title ?? "")")
                            print("body: \(body ?? "" )")
                            
                            self.posts.append(Post(title: title as! String, body: body as! String))
                            print("포스팅 개열의 갯수:",self.posts.count)
                            self.tableView.reloadData()
                            self.tableView.refreshControl?.endRefreshing()
                        }
                    }
                }
            }
        }
    }

 fileprivate func loadMoreData() {
    print("loadMoreData 호출됨")
    AF.request("http://13.209.73.176/api/post/").responseJSON { response in
               //            print(response)
               //            print(response.result)
               
               if let value = response.value as? [String: AnyObject]  {
                   //                print(value)
                   print(value["data"]) // value = api에서 호출한 전체
                   if let array = value["data"] as? NSArray { //data = key값
                       print(array.count)
                       for obj in array {
                           if let dict = obj as? NSDictionary {
                               // Now reference the data you need using:
                               let title = dict.value(forKey: "title")
                               let body = dict.value(forKey: "body")
                               
                               //옵셔널 제거하는 방법 1. guard let
                               //guard let title = dict.value(forKey: "title") else { return }
                               //print("title: \(title)")
                               
                               //방법 2. 옵셔널바인딩. ??
                               print("title: \(title ?? "")")
                               print("body: \(body ?? "" )")
                               
                               self.posts.append(Post(title: title as! String, body: body as! String))
                               print("포스팅 개열의 갯수:",self.posts.count)
                               self.tableView.reloadData()
                               self.tableView.refreshControl?.endRefreshing()
                           }
                       }
                   }
               }
           }
}
}
//MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    //셀 렌더링하는 부분.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        cell.title.text = self.posts[indexPath.row].title
        cell.body.text = self.posts[indexPath.row].body
        
        if indexPath.row == self.posts.count - 1 {
            self.loadMoreData()
        }
        return cell
    }
    
}
