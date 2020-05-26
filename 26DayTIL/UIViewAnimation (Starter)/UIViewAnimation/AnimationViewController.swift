

import UIKit

final class AnimationViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var userIdTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var countDownLabel: UILabel!
    
    @IBOutlet weak var testView: UIView!
    var count = 4 {
        didSet { countDownLabel.text = "\(count)" }
    }
    
    // MARK: - View LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicatorView.isHidden = true // refresh버튼 안보이게 숨길 때
        userIdTextField.center.x = -view.frame.width //-하는 이유는 화면밖으로 밀었다가 나타나게 하기위해서
        passwordTextField.center.x = -view.frame.width
        loginButton.center.x = -view.frame.width
        testView.backgroundColor = .green
    }
    func test(){
        let initialFrame = testView.frame
        UIView.animateKeyframes(
            withDuration: 10,
            delay: 0,
            animations: {
                //(withduration)10초 * 0.0 = 0, 2.5초 동안 애니메이션
                //addkeyframe = 상대적 지속시간, 애니메이션 시간 관련 메서드
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25){
                    self.testView.center.x += 50
                    self.testView.center.y -= 150
                }
                //wintRelativeStartTime = 0 이면 시작하자마자 실행
                //(withduration)10초 * 0.25 = 2.5초, 위에 2.5초 + 여기 2.5초 , 5초 애니메이션
                //relativeDuration = 0.25, withDuration = 10이면 2.5초간 움직이는것
                UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25){
                    self.testView.center.x += 100
                    self.testView.center.y += 50
                }
                //wintRelativeStartTime = 0.25면 2.5초뒤에 실행 시작(withDuration이 10이므로 10의 2.5만큼)
                //(withduration)10초 * 0.7 = 7, 5초간 활동안하고 그후에 5초간 애니메이션
                UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.5){
                    //원래자리로 돌아오도록
                    self.testView.frame = initialFrame
                }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        test()
        UIView.animate(withDuration: 0.6, animations: {
            //bounds로 해야 정확히 부모뷰의 센터로 가게됨(frame 상대값 , bounds절대값)
            self.userIdTextField.center.x = self.userIdTextField.superview!.bounds.midX
        })
        UIView.animate(withDuration: 0.6, delay: 0.5, animations: {
            self.passwordTextField.center.x = self.passwordTextField.superview!.bounds.midX
        })
        //위에 0.5초 이므로 로그인버튼도 delay를 0.5초로 하려면 더해서 1을 넣어야함
        //springwithDamping -> 감쇠 조화 진동자? 굳이 알려고 안해도 됨
        UIView.animate(withDuration: 0.6,
                       delay: 1,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: -5, //속도값
            //[.누르면 curve관련 다양하게 나옴] 기본값은 ease in out/ ,를 써서 여러개 반복으로 사용가능
            // .curveEaseIn , .autoreverse , .repeat 이런식으로
            options: [.curveEaseInOut, .autoreverse], //.repeat도 있음 
            animations: {
                self.loginButton.center.x = self.loginButton.superview!.bounds.midX
        }, completion:  {
            //$0 은 bool값으로 animation이 끝까지 실행되면 true반환 중간에 끊으면 false반환
            print("isFinished:", $0)
        })
    }
    
    // MARK: - Action Handler
    
    @IBAction private func didEndOnExit(_ sender: Any) {}
    
    @IBAction private func login(_ sender: Any) {
        view.endEditing(true)//로그인 버튼 눌럿을 ㄸ ㅐ 키보드가 내려가도록
        
        guard countDownLabel.isHidden else { return } //레이블 숨겨놓은거 꺼낼때
        loginButtonAnimation()
        countDown()
    }
    
    func loginButtonAnimation() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
        
        let centerOrigin = loginButton.center
        UIView.animateKeyframes(withDuration: 1.6,
                                delay: 0,
                                animations: {
                                    //로그인 버튼을 0.4초동안 우측아래로 이동
                                    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
                                        self.loginButton.center.x += 50
                                        self.loginButton.center.y += 20
                                    }
                                    //버튼이 45도 회전하여 우측 상단으로 이동하며 흐려지다가 사라짐
                                    UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25){
                                        self.loginButton.transform = CGAffineTransform(rotationAngle: .pi / 4)
                                        //1/4만큼 회전한 걸 표현하는것 .pi/4
                                        self.loginButton.center.x += 150
                                        self.loginButton.center.y -= 70
                                        self.loginButton.alpha = 0.0//점점 투명해지게
                                    }
                                    //처음에 잇던 위치의 아래에 위치하도록 함(안보이는 상태)
                                    UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: 0.01){
                                        
                                        self.loginButton.transform = .identity //위에서 1/4만큼 회전시킨걸 원래대로
                                        self.loginButton.center = CGPoint(
                                            x: centerOrigin.x,
                                            y: self.loginButton.superview!.frame.height + 120
                                        )
                                    }
                                    //처음의 위치로 돌아오면서 다시 나타남
                                    UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25){
                                        self.loginButton.alpha = 1.0
                                        self.loginButton.center = centerOrigin
                                    }
        }){ _ in
            //로그인버튼 활동이 끝난후 refresh모양도 멈추는
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.isHidden = true
        }
    }
    
    func countDown() {
        countDownLabel.isHidden = false //위에서 hidden시켜놨으므로 풀어줘야함
        UIView.transition(
            with: self.countDownLabel, //같은 view내에서 이뤄지므로 with를 씀
            duration: 0.5,
            options: [.transitionCrossDissolve], //레이블에 효과주는 .transitionFlipFromRight 등 여러가지 있음
            animations: { self.count -= 1 }
        ) { _ in //여긴 애니메이션이 끝났을 때
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                guard self.count == 0 else { return self.countDown() }
                //현재 카운트가 0인지 확인하고 아니면 countDown함수를 재실행 -> 0이 될 때까지
                self.count = 4 //0이되면 카운트를 다시 4로
                self.countDownLabel.isHidden = true //0이 되면 레이블 필요없어지므로 다시 사라지게
                //                            self.activityIndicatorView.stopAnimating()
                //                            self.activityIndicatorView.isHidden = true //여기서 실행하면 레이블이 없어질 때 같이 없어짐
            }
        }
    }
}

