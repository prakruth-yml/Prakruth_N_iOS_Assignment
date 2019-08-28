//
//  MapViewVC.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 24/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewVC: BaseVC {
    
    var latitute: Double = 0.0
    var longitude: Double = 0.0
    var name = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: latitute, longitude: longitude, zoom: 8.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitute, longitude: longitude)
        marker.title = name
        marker.map = mapView
        mapView.frame = view.frame
        view.addSubview(mapView)
    }
}
