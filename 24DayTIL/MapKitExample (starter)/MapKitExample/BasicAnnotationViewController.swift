
import MapKit
import UIKit
//특정위치에 표시하기
final class BasicAnnotationViewController: UIViewController {
  
  @IBOutlet private weak var mapView: MKMapView!
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let center = CLLocationCoordinate2DMake(37.4853775, 126.475315)
    setRegion(coordinate: center)
  }
  
  func setRegion(coordinate: CLLocationCoordinate2D) {
    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) //어느정도 크기로 보여줄지
    let region = MKCoordinateRegion(center: coordinate, span: span)//중앙값
    mapView.setRegion(region, animated: true)
  }
  //핀추가 하는것
  @IBAction private func addAnnotation(_ sender: Any) {
    let myHome = MKPointAnnotation()
    myHome.title = "우리집"
    myHome.subtitle = "인천광역시"
    myHome.coordinate = CLLocationCoordinate2DMake(37.4853775, 126.475315)
    mapView.addAnnotation(myHome)
    
    let cityHall = MKPointAnnotation()
    cityHall.title = "시청"
    cityHall.subtitle = "서울특별시" //시청 핀을 클릭했을 때 그 아래 작게 나오는 글씨
    cityHall.coordinate = CLLocationCoordinate2DMake(37.566308, 126.977948)
    mapView.addAnnotation(cityHall)
    
    let namsan = MKPointAnnotation()
    namsan.title = "남산"
    namsan.coordinate = CLLocationCoordinate2DMake(37.551416, 126.988194)
    mapView.addAnnotation(namsan)
    
    let gimpoAirport = MKPointAnnotation()
    gimpoAirport.title = "김포공항"
    gimpoAirport.coordinate = CLLocationCoordinate2DMake(37.559670, 126.794320)
    mapView.addAnnotation(gimpoAirport)
    
    let gangnam = MKPointAnnotation()
    gangnam.title = "강남역"
    gangnam.coordinate = CLLocationCoordinate2DMake(37.498149, 127.027623)
    mapView.addAnnotation(gangnam)
  }
  
    //핀을 랜덤으로 움직이게 할 때
  @IBAction private func moveToRandomPin(_ sender: Any) {
    guard !mapView.annotations.isEmpty else { return }
    let random = Int.random(in: 0..<mapView.annotations.count) //Int.random = Int형의 랜덤숫자반환
    let annotation = mapView.annotations[random]
    setRegion(coordinate: annotation.coordinate)
  }
  //핀제거
  @IBAction private func removeAnnotation(_ sender: Any) {
    mapView.removeAnnotations(mapView.annotations)
  }
    
    //카메라 설정
    var heading = 0.0
  @IBAction private func setupCamera(_ sender: Any) {
//    mapView.mapType = .hybrid 맵타입을 변경하는것, 어떤 모양으로 바뀌는지 봐둘것
    let camera = MKMapCamera()
    camera.centerCoordinate = CLLocationCoordinate2DMake(37.551416, 126.988194)
    //고도 . 미터단위
    camera.altitude = 200
    //카메라각도 (0일 때 수직으로 내려다보는 형태)
    camera.pitch = 70.0
    heading += 10.0 //카메라 설정 버튼 누를때마다 각도가 +10만큼 변경됨
    camera.heading = heading
    mapView.setCamera(camera, animated: true)
    }
}
