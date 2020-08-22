//
//  MapKitViewController.swift
//  Practice3
//
//  Created by mac on 2020/08/21.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit
import MapKit

class MapKitViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI() {
        let mapkitView = MKMapView()
        mapkitView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        self.view = mapkitView
        self.preferredContentSize.height = 200
        // 표시할 위치
        let pos = CLLocationCoordinate2D(latitude: 37.514322, longitude: 126.894623)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        // 지도영역을정의
        let region = MKCoordinateRegion(center: pos, span: span)
        // 영역을지도뷰에표시
        mapkitView.region = region
        mapkitView.regionThatFits(region)
        // 위치를핀으로표시
        let point = MKPointAnnotation()
        point.coordinate = pos
        mapkitView.addAnnotation(point)

    }
}
