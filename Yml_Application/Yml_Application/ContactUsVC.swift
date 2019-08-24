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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let callUsTGR = UITapGestureRecognizer(target: self, action: #selector(didPressCallUs(_:)))
        let emailTGR = UITapGestureRecognizer(target: self, action: #selector(didPressEmail(_:)))
        let followUsTGR = UITapGestureRecognizer(target: self, action: #selector(didPressFollowUs(_:)))
        let locationsTGR = UITapGestureRecognizer(target: self, action: #selector(didPressLocations(_:)))
        callUsNumber.addGestureRecognizer(callUsTGR)
        businessEmail.addGestureRecognizer(emailTGR)
        followUs.addGestureRecognizer(followUsTGR)
        locations.addGestureRecognizer(locationsTGR)
    }
}

extension ContactUsVC: MFMailComposeViewControllerDelegate {
    
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
//
//        if MFMailComposeViewController.canSendMail(){
//            self.navigationController?.pushViewController(mailComposer, animated: true)
//        }
//        else{
//
//        }
//
        let email = "prakruth.bcbs@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @objc func didPressFollowUs(_ sender: UITapGestureRecognizer){
        
        if let fbUrl = URL(string: "fb://profile/prakruth.nagaraj"){
            let application: UIApplication = UIApplication.shared
            application.open(fbUrl, options: [:], completionHandler: nil)
        }
    }
    
    @objc func didPressLocations(_ sender: UITapGestureRecognizer){
    }
    
}
