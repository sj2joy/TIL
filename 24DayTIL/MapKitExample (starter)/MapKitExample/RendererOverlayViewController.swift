

import MapKit
import UIKit

final class RendererOverlayViewController: UIViewController {
  
  @IBOutlet private weak var mapView: MKMapView!
  
    override func viewDidLoad() {
        let center = CLLocationCoordinate2DMake(37.4853775, 126.475315 )
           setRegion(coordinate: center)
         }
         
         func setRegion(coordinate: CLLocationCoordinate2D) {
           let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
           let region = MKCoordinateRegion(center: coordinate, span: span)
           mapView.setRegion(region, animated: true)
         
    }
    //원 모양 오버레이 추가 ( 아래 extension 으로 추가 더해줘야함)
  @IBAction func addCircle(_ sender: Any) {
    let center = mapView.centerCoordinate
    let circle = MKCircle(center: center, radius: 40000) //radius는 meter단위
    mapView.addOverlay(circle) //여기까지 작성하고 델리게이트 연결해줘야 함
  }
  // 별 모양의 오버레이 추가-- 이건 기본적으로 있는게 아니라서 직접 만들어야함()
  @IBAction func addStar(_ sender: Any) {
    let center = mapView.centerCoordinate
    var point1 = center; point1.latitude += 0.65
    var point2 = center; point2.longitude += 0.4;   point2.latitude -= 0.15
    var point3 = center; point3.longitude -= 0.45;  point3.latitude += 0.4
    var point4 = center; point4.longitude += 0.45;  point4.latitude += 0.4
    var point5 = center; point5.longitude -= 0.4;   point5.latitude -= 0.15
    let points: [CLLocationCoordinate2D] = [point1, point2, point3, point4, point5, point1]
    let polyline = MKPolyline(coordinates: points, count: points.count)
    mapView.addOverlay(polyline)
  }
    @IBAction func addTriangle(_ sender : Any){
        let myHome = MKPointAnnotation()
        myHome.title = "우리집"
        myHome.subtitle = "인천광역시"
        myHome.coordinate = CLLocationCoordinate2DMake(37.4853775, 126.475315)
        mapView.addAnnotation(myHome)
        
        let center = mapView.centerCoordinate
        var point1 = center; point1.latitude += 0.05
        var point2 = center; point2.latitude -= 0.02; point2.longitude -= 0.03;
        var point3 = center; point3.latitude -= 0.02; point3.longitude += 0.04;
        let points : [CLLocationCoordinate2D] = [point1, point2, point3, point1]
        let triangle = MKPolyline(coordinates: points, count: points.count)
        mapView.addOverlay(triangle)
        
    }
  @IBAction private func removeOverlays(_ sender: Any) {
    mapView.removeOverlays(mapView.overlays)
    }
}

//MARK: -MKMapViewDelegate

extension RendererOverlayViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer{
        //addOverlay가 여기로 들어오게됨
        if let circle = overlay as? MKCircle {
            let renderer = MKCircleRenderer(circle: circle)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 2
            return renderer
        }
        if let polyline = overlay as? MKPolyline{
            let renderer = MKPolylineRenderer(polyline: polyline)
            //아래 두줄 설정안하면 나머지를 해도 앱상에서 표시가 안됨
            renderer.strokeColor = .red
            renderer.lineWidth = 2
            return renderer
        }
        if let triangle = overlay as? MKPolyline{
            let renderer = MKPolylineRenderer(polyline: triangle)
            renderer.strokeColor = .red
            renderer.lineWidth = 3
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}
