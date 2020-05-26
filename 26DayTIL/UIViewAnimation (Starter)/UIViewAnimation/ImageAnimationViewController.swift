

import UIKit

final class ImageAnimationViewController: UIViewController {
  
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var durationLabel: UILabel!
  @IBOutlet private weak var repeatCountLabel: UILabel!
  
    let images: [UIImage] = [
    "AppStore", "Calculator", "Calendar", "Camera", "Clock", "Contacts", "Files"
    ].compactMap(UIImage.init(named:))//.compactMap을 쓰면 string타입의 배열을 uiimage타입으로 바꿔서 다른데 사용가능
  
  override func viewDidLoad() {
    super.viewDidLoad()
    imageView.animationImages = images
  }
  //start버튼 클릭시 동작
  @IBAction private func startAnimation(_ sender: Any) {
    imageView.startAnimating()
    }
  //stop버튼 클릭시 동작
  @IBAction private func stopAnimation(_ sender: Any) {
    guard imageView.isAnimating else { return }
    imageView.stopAnimating()
  }
  //duration버튼 클릭시 동작 (화면 전환속도와 연관)
  @IBAction private func durationStepper(_ sender: UIStepper) {
    durationLabel.text = "\(sender.value)"
    imageView.animationDuration = sender.value
    //default 0 - 1/30초
  }
  //repeatcount버튼 클릭시 동작 (화면전환 횟수(사이클단위 (3입력시 3사이클회전) 제한에 관련)
  @IBAction private func repeatCountStepper(_ sender: UIStepper) {
    let repeatCount = Int(sender.value)
    repeatCountLabel.text = "\(repeatCount)"
    imageView.animationRepeatCount = repeatCount
    //default 0-무한반복
  }
}
