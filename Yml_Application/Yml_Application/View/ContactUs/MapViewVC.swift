//
//  MapViewVC.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 24/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewVC: UIViewController {
    
    var latitute: Double = 0.0
    var longitude: Double = 0.0
    var name = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: latitute, longitude: longitude, zoom: 8.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitute, longitude: longitude)
        marker.title = name
//        marker.snippet = "Aus"
        marker.map = mapView

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
