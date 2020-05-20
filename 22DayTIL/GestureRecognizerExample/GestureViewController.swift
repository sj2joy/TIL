

import UIKit
import AudioToolbox.AudioServices

final class GestureViewController: UIViewController {
    
    var isQuardruple = false
    var rotateImage = false
    @IBOutlet private weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
    }
    
    //TapGesture - Discrete(한번에 하나의 형태만 인식하는)
    @IBAction func handleTapGesture(_ sender: UITapGestureRecognizer) {
        print("tap!!") //TapGestureRecognizer에서 tap은 터치횟수, touches는 손가락 갯수
        //이미지 클릭시 4배로 확대 되었다가 재클릭시 원래대로
        guard sender.state == .ended else { return }
        
        if !isQuardruple {
            imageView.transform = imageView.transform.scaledBy(x: 2, y: 2) // x축 2배, y축 2배 == 4배
            //imageView.transform = imageView.transform.translatedBy(x: 2, y: 2)// x,y축으로 2씩 옮기는
            //imageView.transform = imageView.transform.rotated(by: 50)//회전과 관련된
        } else {
            imageView.transform = CGAffineTransform.identity// 원래 크기로 복귀
        }
        isQuardruple.toggle()
    }
    
    @IBAction private func handleRotationGesture(_ sender: UIRotationGestureRecognizer) {
        print("rotation")
        imageView.transform = imageView.transform.rotated(by: sender.rotation) // 이거만 쓰면 회전율? 이 높아서 계속 돌아감
        sender.rotation = 0 // 로테이션값을 초기화해줘서 회전율 조절해야함
    }
    
    
    @IBAction func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        //좌우로 드래그했을 때 이미지 변경되도록
        if sender.direction == .left{
            imageView.image = UIImage(named: "cat1")
            sender.direction = .right
        } else {
            imageView.image = UIImage(named: "cat2")
            sender.direction = .left
        }
    }
    
    var initialCenter = CGPoint()
    //이미지 누른채로 드래그하기
    @IBAction func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        
        guard let dragView = sender.view else { return }
        
        let translation = sender.translation(in: dragView.superview) //dragView.superView = rootView
        dragView.isUserInteractionEnabled = true//이미지뷰는 뷰와 다르게 isUserInteractionEnabled가 비활성화 되잇기때문에
        //이미지 뷰에 넣을 때는 이걸 꼭 써줘야됨 !!!!!!!!!!!!!
        
        //시작점
        if sender.state == .began {
            initialCenter = dragView.center //dragView = imageView
        }
        //캔슬이 아니면 시작점에서 지정된x,y값만큼 이동
        if sender.state != .cancelled {
            dragView.center = CGPoint(x: initialCenter.x + translation.x,
                                      y: initialCenter.x + translation.y)
        } else {//캔슬일 경우 원위치로
            dragView.center = initialCenter
        }
    }
//    import AudioToolbox.AudioServices
    private func vibrate() {//나중에 진동 설정 해볼것
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
