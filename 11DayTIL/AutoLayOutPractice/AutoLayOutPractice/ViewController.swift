

import UIKit

class ViewController: UIViewController {
    var redView = UIView()
    var blueView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(view.safeAreaInsets)  // 0,0,0,0
        //viewSafeAreaInsetsDidChange() // --> 이게 불리면 0000이 아니라 입력된 프레임이 들어감
        print("safeAreaInsets" , view.safeAreaInsets)
    }
    override func viewSafeAreaInsetsDidChange() {
        colorView()
    }
    func colorView() {
        let viewW = view.frame.width
        let viewH = view.frame.height
        let safeT = view.safeAreaInsets.top
        let safeB = view.safeAreaInsets.bottom
        let safeL = view.safeAreaInsets.left
        let safeR = view.safeAreaInsets.right
      
        redView.frame = CGRect(
        x: (safeL+20),
        y: (safeT+20),
        width: ((viewW-safeL-safeR)/2-25),
        height: (viewH-safeB-safeT-20))
        redView.backgroundColor = .systemRed
        view.addSubview(redView)
        
        blueView.frame = CGRect(
        x: redView.frame.maxX+10,
        y: redView.frame.minY,
        width: redView.frame.width,
        height: redView.frame.height)
        blueView.backgroundColor = .systemBlue
        view.addSubview(blueView)
        
    }
}

