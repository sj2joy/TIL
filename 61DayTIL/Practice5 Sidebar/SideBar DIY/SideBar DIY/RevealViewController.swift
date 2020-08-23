//
//  ViewController.swift
//  SideBar DIY
//
//  Created by mac on 2020/08/22.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class RevealViewController: UIViewController {
    
    var contentVC: UIViewController? // 콘텐츠를 담당할 뷰 컨트롤러
    var sideBarVC: UIViewController? // 사이드 바 메뉴를 담당할 뷰 컨트롤러
    var isSideBarShowing = false // 현재 사이드 바가 열려 있는지 여부
    let sideBarInterval = 0.3 // 사이드 바가 열리고 닫히는 데 걸리는 시간
    let sideBarWidth: CGFloat = 260 // 사이드 바가 열릴 너비
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // 초기 화면 설정
    func setupView() {
        //프론트 컨트롤러 객체를 읽어옴
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_front") as? UINavigationController {
            //읽어온 컨트롤러를 클래스 전체에서 참조할 수 있도록 contentVC 속성에 저장한다.
            self.contentVC = vc
            //프론트 컨트롤러 객체를 메인 컨트롤러의 자식으로 등록
            self.addChild(vc)
            //프론트 컨트롤러를 메인 컨트롤러의 자식 뷰 컨트롤러로 등록
            self.view.addSubview(vc.view) //프론트 컨트롤러의 뷰를 메인 컨트롤러의 서브 뷰로 등록
            //프론트 컨트롤러에 부모 뷰 컨트롤러가 바뀌었음을 알려준다.
            vc.didMove(toParent: self)
            let frontVC = vc.viewControllers[0] as? FrontViewController
            frontVC?.delegate = self
        }
    }
    
    // 사이드 바의 뷰 읽어오기
    func getSideView() {
        if self.sideBarVC == nil {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_rear") {
                self.sideBarVC = vc
                self.addChild(vc)
                self.view.addSubview(vc.view)
                vc.didMove(toParent: self)
                //프론트 컨트롤러의 뷰를 제일 위로 올림
                self.view.bringSubviewToFront((self.contentVC?.view)!)
                
            }
        }
    }
    // 콘텐츠 뷰에 그림자 효과
    func setShadowEffect(shadow: Bool, offset: CGFloat) {
        if (shadow == true) {// 그림자 효과 설정
            self.contentVC?.view.layer.cornerRadius = 10 // 그림자 모서리 둥글기
            self.contentVC?.view.layer.shadowOpacity = 0.8 // 그림자 투명도
            self.contentVC?.view.layer.shadowColor = UIColor.black.cgColor // 그림자 색상
            self.contentVC?.view.layer.shadowOffset = CGSize(width: offset, height: offset)//그림자 크기
            self.contentVC?.view.layer.cornerRadius = 0.0
        } else {
            self.contentVC?.view.layer.shadowOffset = CGSize(width:0, height:0)
        }
    }
    
    func openSideBar(_ complete: ( () -> Void)? ) {
        
        self.getSideView() // 사이드 바 뷰를 읽어온다.
        self.setShadowEffect(shadow: true, offset: -2) //그림자효과 주기
        //애니메이션 옵션
        //beginFromCurrentState = 다른 애니메이션이 진행중이어도 동시에 진행하라는 명령어
        let options = UIView.AnimationOptions( [.curveEaseInOut, .beginFromCurrentState])
        //애니메이션 실행
        UIView.animate(
            withDuration: TimeInterval(self.sideBarInterval),
            delay: TimeInterval(0),
            options: options,
            animations: {
                self.contentVC?.view.frame = CGRect(x: self.sideBarWidth,
                                                    y: 0,
                                                    width: self.view.frame.width,
                                                    height: self.view.frame.height)
        },
            completion: {
                if $0 == true {
                    self.isSideBarShowing = true // 열림 상태로 플래그를 변경한다.
                    complete?()
                }
        }
        )
    }
    func closeSideBar(_ complete: ( () -> Void)? ) {
        // 애니메이션 옵션을 정의한다.
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        // 애니메이션 실행
        UIView.animate(
            withDuration: TimeInterval(self.sideBarInterval),
            delay: TimeInterval(0),
            options: options,
            animations: {
                // 1 옆으로 밀려난 콘텐츠 뷰의 위차를 제자리로
                self.contentVC?.view.frame = CGRect(x:0,
                                                    y:0,
                                                    width:self.view.frame.width,
                                                    height:self.view.frame.height)
        },
            completion: {
                if $0 == true {
                    //사이드 바 뷰를 제거
                    self.sideBarVC?.view.removeFromSuperview()
                    self.sideBarVC = nil
                    //닫힘 상태로 플래그를 변경
                    self.isSideBarShowing = false
                    //그림자 효과를 제거
                    self.setShadowEffect(shadow: false, offset: 0)
                    //인자값으로 입력받은 완료 함수 실행
                    complete?()
                    
                }
            }
        )
    }
}
