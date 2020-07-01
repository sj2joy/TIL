//
//  ViewController.swift
//  pagerViewTutorial
//
//  Created by mac on 2020/06/29.
//  Copyright © 2020 Seokjin. All rights reserved.
//
import UIKit
import FSPagerView

class ViewController: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
    
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var leftBtn: UIButton!
    
    fileprivate let imageNames = ["image1.png", "image2.png", "image3.png", "image4.png"]
    
    @IBOutlet weak var myPageView: FSPagerView! {
        didSet {
            self.myPageView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            //아이템크기설정
            self.myPageView.itemSize = FSPagerView.automaticSize
            //무한스크롤 설정
            self.myPageView.isInfinite = true
            //자동 스크롤 설정(4초마다 자동으로 넘어감)
//            self.myPageView.automaticSlidingInterval = 4.0
        }
    }
    
    @IBOutlet weak var myPageControl: FSPageControl! {
        didSet {
            self.myPageControl.numberOfPages = self.imageNames.count
            self.myPageControl.contentHorizontalAlignment = .center
            self.myPageControl.itemSpacing = 16
            self.myPageControl.interitemSpacing = 16
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leftBtn.layer.cornerRadius = self.leftBtn.frame.height / 2
        self.rightBtn.layer.cornerRadius = self.rightBtn.frame.height / 2
        self.myPageView.dataSource = self
        self.myPageView.delegate = self
    }
    @IBAction func onLeftBtnClicked(_ sender: UIButton) {
        self.myPageControl.currentPage = self.myPageControl.currentPage - 1
        self.myPageView.scrollToItem(at: self.myPageControl.currentPage, animated: true)
    }
    @IBAction func onRightBtnClicked(_ sender: UIButton) {
        if(self.myPageControl.currentPage == self.imageNames.count - 1) {
            self.myPageControl.currentPage = 0
        } else {
            self.myPageControl.currentPage = self.myPageControl.currentPage + 1
        }
        self.myPageView.scrollToItem(at: self.myPageControl.currentPage, animated: true)
    }
    
    //MARK: - FSPageViewDataSource, FSPagerViewDelegate
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
    //각 셀에 대한 설정
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFit
        return cell
    }
    //MARK: - FSPagerView delegate
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.myPageControl.currentPage = targetIndex
    }
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.myPageControl.currentPage = pagerView.currentIndex
    }
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
}


