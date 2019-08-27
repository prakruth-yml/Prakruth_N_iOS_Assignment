//
//  ContactUsVC.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 21/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit
import MessageUI

class ContactUsVC: UIViewController {

    @IBOutlet weak var callUsNumber: UILabel!
    @IBOutlet weak var businessEmail: UILabel!
    @IBOutlet weak var followUs: UILabel!
    @IBOutlet weak var locations: UILabel!
    @IBOutlet weak var locationsSiliconValley: UILabel!
    
    var viewModel = ContactUsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let callUsTGR = UITapGestureRecognizer(target: self, action: #selector(didPressCallUs(_:)))
        let emailTGR = UITapGestureRecognizer(target: self, action: #selector(didPressEmail(_:)))
        let followUsTGR = UITapGestureRecognizer(target: self, action: #selector(didPressFollowUs(_:)))
        let locationsTGR = UITapGestureRecognizer(target: self, action: #selector(didPressLocations(_:)))
        let locationsSVTGR = UITapGestureRecognizer(target: self, action: #selector(didPressLocationsSV(_:)))
        locationsSiliconValley.addGestureRecognizer(locationsSVTGR)
        callUsNumber.addGestureRecognizer(callUsTGR)
        businessEmail.addGestureRecognizer(emailTGR)
        followUs.addGestureRecognizer(followUsTGR)
        locations.addGestureRecognizer(locationsTGR)
    }
    
    @objc func didPressCallUs(_ sender: UITapGestureRecognizer){
        
        if let number = callUsNumber {
            let temp = "tel://\(number.text ?? "973926767")"
            if let phoneCallURL = URL(string: temp) {
                let application:UIApplication = UIApplication.shared
                application.open(phoneCallURL, options: [:], completionHandler: nil)
                //                if (application.canOpenURL(phoneCallURL)) {//                }
            }
        }
    }
    
    @objc func didPressEmail(_ sender: UITapGestureRecognizer){
        
//        let mailComposer = MFMailComposeViewController()
//        mailComposer.mailComposeDelegate = self
//        mailComposer.setToRecipients(["prakruth.bcbs@gmail.com"])
//        mailComposer.setSubject("Test")
//        mailComposer.setMessageBody("Test", isHTML: false)
//        if MFMailComposeViewController.canSendMail(){
//            self.navigationController?.pushViewController(mailComposer, animated: true)
//        }
//        else{
//        
//        }
        let email = "prakruth.bcbs@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func didPressFollowUs(_ sender: UITapGestureRecognizer){
        
        if let fbUrl = URL(string: "fb://profile/prakruth.nagaraj"){
            let application: UIApplication = UIApplication.shared
            application.open(fbUrl, options: [:], completionHandler: nil)
        }
    }
    
    func showMaps(latitude: Double, longitude: Double, name: String){
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: MapViewVC.self)) as? MapViewVC{
            viewController.latitute = latitude
            viewController.longitude = longitude
            viewController.name = name
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @objc func didPressLocations(_ sender: UITapGestureRecognizer){
        //getLatLongFromString(addr: "Bangalore")
        let temp = viewModel.getBangalore()
        showMaps(latitude: temp.latitude, longitude: temp.longitude, name: temp.name)
    }
    
    @objc func didPressLocationsSV(_ sender: UITapGestureRecognizer){
        //getLatLongFromString(addr: "Bangalore")
        let temp = viewModel.getLa()
        showMaps(latitude: temp.latitude, longitude: temp.longitude, name: temp.name)
    }
    
    //Function to make API call to Google. Returns json response with the lats and longs
    func getLatLongFromString(addr: String){
        var urlComponents = URLComponents(string: "https://maps.googleapis.com/maps/api/geocode/json")
        let appKeyQuery = URLQueryItem(name: "key", value: AppDelegate.googleMapsApiKey)
        let countryQuery = URLQueryItem(name: "address", value: addr)
        urlComponents?.queryItems = [appKeyQuery, countryQuery]
        
        guard let apiUrl = urlComponents?.url else { fatalError("No Url") }
        let task = URLSession.shared.dataTask(with: apiUrl) { data, response, error in
            guard let data = data else { fatalError("Error") }
            guard let jsonResponse = (try? JSONSerialization.jsonObject(with: data)) as? [String : Any] else { fatalError("No Response") }
            print(jsonResponse)
//            guard let results = jsonResponse["results"] as? [[String : Any]] else { fatalError("No results") }
            guard let geometry = jsonResponse["geometry"] as? [String : Any] else { fatalError("No Geometry") }
            print("*************************")
            print(geometry)
            guard let location = geometry["location"] as? [String : Any] else { fatalError("No location") }
            print("*************************")
            print(location)
        }
        task.resume()
    }
}

extension ContactUsVC: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
