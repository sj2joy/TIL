

import UIKit


final class ViewController: UIViewController {

  // MARK: Properties
  
  @IBOutlet private weak var scrollView: UIScrollView!
  @IBOutlet private weak var imageView: UIImageView!
  //미니멈 맥시멈 스케일 정하고 델리게이트에서 나머지 설정
    private var zoomScale: CGFloat = 1.0
  // MARK: LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    scrollView.delegate = self
    scrollView.bounces = true
//    scrollView.alwaysBounceHorizontal = true 드래그햇을때 여백공간이 보이게
    updateScrollViewZoomScale()
  }
  
  // MARK: Action Handler
    private func updateScrollViewZoomScale(){
        //scrollview 어트리뷰트 텝에서 min max 는 배율
        //코드로는 아래처럼 계산해서 넣을수 잇슴
        
        let widthScale = view.frame.width / imageView.bounds.width
        let heightScale = view.frame.height / imageView.bounds.width
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = 1
        scrollView.maximumZoomScale = 3
    }
  @IBAction private func fitToWidth(_ sender: Any) {
    print("\n---------- [ fitToWidth ] ----------")
    zoomScale = scrollView.frame.width / imageView.bounds.width
    scrollView.setZoomScale(zoomScale, animated: true)
    print(scrollView.frame.width)
    print(imageView.bounds.width)
    print(zoomScale)
 }
  
  @IBAction private func scaleDouble(_ sender: Any) {
    print("\n---------- [ scaleDouble ] ----------")
    scrollView.setZoomScale(zoomScale * 2, animated: true)
    //곱셈값이 커져도 지정해놓은 최소, 최대값 이상으로 올라가지않는다
    print(zoomScale)
    zoomScale = scrollView.zoomScale
    print(zoomScale)
    
    //특정위치에 줌을 땡기고 싶을 때
    let rectToVisible = CGRect(x: 100, y: 100, width: 200, height: 300)
    scrollView.zoom(to: rectToVisible, animated: true)
  }

  @IBAction private func moveContentToLeft(_ sender: Any) {
    print("\n---------- [ moveContentToLeft ] ----------")
    //클릭시 마다 컨텐츠 이동(설정한 값만큼 누를 때 마다 이동)
    let newOffset = CGPoint(x: scrollView.contentOffset.x + 150, y: scrollView.contentOffset.y)
    scrollView.setContentOffset(newOffset, animated: true)//bounds를 쓰기보단 contentOffset을 씀
  }
    func printInfo() {
      print("\n---------- [ ScrollView Info ] ----------")
      print("frame : ", scrollView.frame)
      print("contentSize : ", scrollView.contentSize)
      print("bounds : ", scrollView.bounds)
      print("contentOffset : ", scrollView.contentOffset)
    }
}

extension ViewController : UIScrollViewDelegate{
    //zoom에 관한 델리게이트
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        printInfo()
    }
}
