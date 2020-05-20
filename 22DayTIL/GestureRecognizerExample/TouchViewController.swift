
import UIKit

final class TouchViewController: UIViewController {

    var isHoldingImage = false //화면 드래그를 빨리해도 안끊기게 만들도록 하기위해 임시로 만들어놓은 프로퍼티
                                    // 각 메서드에 들어가있는데 위치랑 true false값 잘보기
    var lastTouchPoint = CGPoint.zero //이미지 클릭할때마다 클릭된 위치에 이미지의 센터가 오는것을 막기위해 임시로 만든 프로퍼티
                                        // 각 메서드에서 어떤식으로 작용하는지 볼 것
    
    
  @IBOutlet private weak var imageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    imageView.layer.cornerRadius = imageView.frame.width / 2
    //    imageView.clipsToBounds = true  아래랑 같음 , imageView에서 필요없는부분을 자르는? 그런 명령어
    imageView.layer.masksToBounds = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("touches Began")
        //첫번째 터치 되는걸 변수로 만들고 그 위치프레임을 찍는것
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: touch.view) //어느포인트에 터치햇는지 확인하는
        print("touchPoint :" , touchPoint)
        //cat1이미지를 누르고있을 때 cat2이미지가 보이도록 하는것(이미지뷰 내부를 클릭했을 때)
        if imageView.frame.contains(touchPoint) {
            imageView.image = UIImage(named: "cat2")
            isHoldingImage = true
            lastTouchPoint = touchPoint
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard isHoldingImage, let touch = touches.first else { return }
        let touchPoint = touch.location(in: touch.view)
        //lastTouchPoint 지정해놓은거 여기서 사용
        imageView.center.x  = imageView.center.x + (touchPoint.x - lastTouchPoint.x)
        imageView.center.y  = imageView.center.y + (touchPoint.y - lastTouchPoint.y)
        lastTouchPoint = touchPoint
        print("move")

        //위에 lastTouchPoint 사용한것과 같은 내용, but previousLocation은 크게 움직이거나 화면밖으로 나갔을 때 조금 버벅거림
        //그게 상관없으면 이걸 써도 되지만 엥간하면 위에거 사용(좀 더 안정적임)
//        let prevTouchPoint = touch.previousLocation(in: touch.view)
//        imageView.center.x  = imageView.center.x + (touchPoint.x - prevTouchPoint.x)
//        imageView.center.y  = imageView.center.y + (touchPoint.y - prevTouchPoint.y)

    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        print("end")
        //cat1이미지 누르고잇던걸 풀면 다시 돌아오는것
        imageView.image = UIImage(named: "cat1")
        isHoldingImage = false

    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        //cat1이미지 누르고잇던걸 풀면 다시 돌아오는것(cancelled 됐을 때 안바뀔수도 있으므로 여기도 해줘야함
        imageView.image = UIImage(named: "cat1")
        isHoldingImage = false

        print("cancel")
    }
}



