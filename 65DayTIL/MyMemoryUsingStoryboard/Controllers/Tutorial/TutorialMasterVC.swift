//
//  TutorialMasterVC.swift
//  MyMemoryUsingStoryboard
//
//  Created by mac on 2020/08/31.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class TutorialMasterVC: UIViewController {
    
    var pageVC: UIPageViewController!
    var contentTitles = ["STEP 1", "STEP 2", "STEP 3", "STEP 4"]
    var contentImages = ["Page0", "Page1", "Page2", "Page3"]
    
    @IBAction func close(_ sender: UIButton) {
        let ud = UserDefaults.standard
        ud.set(true, forKey: UserInfoKey.tutorial)
        ud.synchronize()
        
        self.presentingViewController?.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageVC = self.instanceTutorialVC(name: "PageVC") as? UIPageViewController
        self.pageVC.dataSource = self
        
        setupUI()
    }
    private func setupUI() {
        
        let startContentVC = self.getContentVC(atIndex: 0)!
        self.pageVC.setViewControllers([startContentVC], direction: .forward, animated: true)
        
        pageVC.view.frame.origin = CGPoint(x: 0, y: 0)
        pageVC.view.frame.size.width = self.view.frame.width
        pageVC.view.frame.size.height = self.view.frame.height - 50
        
        addChild(self.pageVC)
        view.addSubview(pageVC.view)
        pageVC.didMove(toParent: self)
    }
    
    func getContentVC(atIndex idx: Int) -> UIViewController? {
        guard self.contentTitles.count >= idx && self.contentTitles.count > 0 else {
            return nil
        }
        guard let contentsVC = self.instanceTutorialVC(name: "ContentsVC") as? TutorialContentsVC else {
            return nil
        }
        contentsVC.titleText = self.contentTitles[idx]
        contentsVC.imageFile = self.contentImages[idx]
        contentsVC.pageIndex = idx
        return contentsVC
    }
}

//MARK: - UIPageViewControllerDataSource

extension TutorialMasterVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard var index = (viewController as! TutorialContentsVC).pageIndex else {
            return nil
        }
        guard index > 0 else { return nil }
        index -= 1
        return self.getContentVC(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard var index = (viewController as! TutorialContentsVC).pageIndex else {
            return nil
        }
        index += 1
        guard index < self.contentTitles.count else { return nil }
        return self.getContentVC(atIndex: index)
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.contentTitles.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

