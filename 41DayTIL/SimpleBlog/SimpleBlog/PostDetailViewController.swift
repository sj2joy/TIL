//
//  PostDetailViewController.swift
//  SimpleBlog
//
//  Created by mac on 2020/06/11.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit
import Alamofire

class PostDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!
    
    
    
    var post: Post? {
        didSet {
            print("post didSet : \(post?.title)")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("PostDetailViewController - viewDidLoad() 호출됨. post.id:  \(post?.id)")
        print("PostDetailViewController - viewDidLoad() 호출됨. post.title:  \(post?.title)")
        print("PostDetailViewController - viewDidLoad() 호출됨. post.body:  \(post?.body)")
        
        bodyLabel.text = post?.body
        titleLabel.text = post?.title
        
        let barBtn = UIBarButtonItem(title: "수정하기", style: .plain, target: self, action: #selector(goToEditPostView))
        let barBtn2 = UIBarButtonItem(title: "삭제하기", style: .plain, target: self, action: #selector(deletePostView))
        navigationItem.rightBarButtonItems = [barBtn, barBtn2]
        //        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정하기", style: .plain, target: self, action: #selector(goToEditPostView))
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated )
    }
    
    @objc private func deletePostView() {
        print("Delete Btn")
        
        guard let postId = post?.id else { return }
        
        AF.request("http://13.209.73.176/api/post/\(postId)",
                   method: .delete,
                   parameters: nil,
                   encoding: JSONEncoding.default)
            .responseJSON{ (response) in
                print("삭제여부: \(postId)")
                
                self.navigationController?.popViewController(animated: true)
        }
    }
    @objc private func goToEditPostView() {
        print("goToEditPostView")
        performSegue(withIdentifier: "goToEditPostVC", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToEditPostVC") {
            var vc = segue.destination as! EditPostViewController
            print("segue로 넘어옴")
            
            vc.receivedPost = self.post
            vc.delegate = self
        }
    }
}

//MARK: - EditPostViewControllerDelegate
extension PostDetailViewController: EditPostViewControllerDelegate {
    func editPostCompleted(editedPostItem: Post) {
        print("PostDetailViewController - editedPostCompleted / \(editedPostItem.title) ")
        titleLabel.text = editedPostItem.title
        bodyLabel.text  = editedPostItem.body
    }
}
