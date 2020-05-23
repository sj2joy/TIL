

import MapKit
import UIKit

final class MyLocationViewController: UIViewController {
    
    @IBOutlet private weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAuthorizationStatus()//권한승인
        locationManager.delegate = self
        mapView.showsUserLocation = true //내 위치 보이게(시뮬레이터에서 점이라고 보면됨)
        mapView.mapType = .satellite

    }
    
    
    func checkAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus(){//현재 권한상태 물어보기
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()//권한요청
//            locationManager.requestAlwaysAuthorization()
        case .restricted, .denied: break
        case .authorizedWhenInUse:
            fallthrough
        case .authorizedAlways:
            startUpdatingLocation()
        @unknown default: break
            
        }
    }
    
    func startUpdatingLocation() {
        let status = CLLocationManager.authorizationStatus()
        guard status == .authorizedWhenInUse || status == .authorizedAlways else {
            return }
        guard CLLocationManager.locationServicesEnabled() else { return }//서비스를 사용가능한지 물어보는
        //    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters //위치정확도
        //    locationManager.distanceFilter = 10.0 //10미터 이동시마다 갱신함 ,
        // 위 2줄은 안쓰면 기본값이 적용됨
        locationManager.startUpdatingLocation()//실제로 동작을 시키는 부분
        //작성하고 infoplist에서 요청할 때 메시지를 알려야함
    }
    
    @IBAction func mornitoringHeading(_ sender: Any) { //헤딩 정보 받아오는것
        guard CLLocationManager.headingAvailable()  else { return }
        locationManager.startUpdatingHeading()
    }
    
    @IBAction func stopMornitoring(_ sender: Any) {
        locationManager.stopUpdatingHeading()
    }
}



// MARK: - CLLocationManagerDelegate

extension MyLocationViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){//권한상태변화 체크
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            print("allowed")
        default:
            print("default")
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){//startupdating했을 때 업데이트가 되는지 확인하는
        let current = locations.last!
        let coordinate = current.coordinate//좌표값 가져오는
        
        if (abs(current.timestamp.timeIntervalSinceNow) < 10) {//if문은 앱을 종료했다가 다시 시작했을 때 이전에 가지고 있던 값들을 무시하고 10초 이내의 값만 사용하도록 설정하는 것
            let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)//이 숫자가 클수록 큰 범위를 다루게되고 작을 수록 크게보임
            let region = MKCoordinateRegion(center: coordinate, span: span)//현재의 위치를 span만큼 보여지도록
            mapView.setRegion(region, animated: true)
            addAnnotation(location : current)
        }
    }
    func addAnnotation(location: CLLocation) {//내가 이동한 위치에 마크같은걸 남기고 싶을 때
        let annotation = MKPointAnnotation()
        annotation.title = "MyLocation"
        annotation.coordinate = location.coordinate
        mapView.addAnnotation(annotation)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading){
        print("trueHeading: ", newHeading.trueHeading) // 진북
        print("magneticHeading:", newHeading.magneticHeading) //자북
        print("values \(newHeading.x), \(newHeading.y), \(newHeading.z)")
    }
}


