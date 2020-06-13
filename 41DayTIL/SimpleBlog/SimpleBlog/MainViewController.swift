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
    
    var page = 0
    
    var selectedPost: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //데이터 가져오기
        loadMoreData(page: 1)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        //네비게이션
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(goToCreateView))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBtnClicked(_:)))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear Called")
        handleRefresh()
    }
    
    //MARK: - selector 메서드
    @objc private func goToCreateView() {
        print("goToCreateView")
        performSegue(withIdentifier: "goToCreatePostVC", sender: self)
    }
//    @objc private func rightBtnClicked(_ sender: UIBarButtonItem) {
//        print("rightBtnClicked")
//    }
    @objc private func handleRefresh() {
        posts.removeAll()
        print("호출됨")
        self.page = 1
        loadMoreData(page: page )
    }
    
    //MARK: - private method
    fileprivate func loadMoreData(page: Int) {
        print("loadMoreData 호출됨")
        self.page = page + 1
        
        let parameters = ["page": String(page)]
        
        AF.request("\(Constants.API.GET_POSTS)", parameters: parameters).responseJSON { response in
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
                            guard let id = dict.value(forKey: "id") else { return }
                            
                            //옵셔널 제거하는 방법 1. guard let
                            //guard let title = dict.value(forKey: "title") else { return }
                            //print("title: \(title)")
                            
                            //방법 2. 옵셔널바인딩. ??
                            print("id: \(id)")
                            print("title: \(title ?? "")")
                            print("body: \(body ?? "" )")
                            
                            self.posts.append(Post(id: "\(id)", title: title as! String, body: body as! String))
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPost = posts[indexPath.row]
        print("selected tableView: \(indexPath.row)")
        print("self.SelectedPost.title: \(self.selectedPost?.title)")
    
        //화면전환을 발생시킴
        performSegue(withIdentifier: "goToPostDetailVC", sender: self)
    }
    
    //셀 렌더링하는 부분.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        cell.title.text = self.posts[indexPath.row].title
        cell.body.text = self.posts[indexPath.row].body
        
        if indexPath.row == self.posts.count - 1 {
            self.loadMoreData(page: self.page)
        }
        return cell
    }
    
    //화면을 넘기는 부분
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToPostDetailVC") {
            var vc = segue.destination as! PostDetailViewController
            print("segue로 넘어옴")
            
            vc.post = self.selectedPost
        }
    } 
}
