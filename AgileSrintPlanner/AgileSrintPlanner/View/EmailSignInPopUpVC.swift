//
//  EmailSignInPopUpVC.swift
//  AgileSrintPlanner
//
//  Created by Prakruth Nagaraj on 03/09/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class EmailSignInPopUpVC: BaseVC {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var firebaseManager = FirebaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        signUpButton.imageView?.contentMode = .scaleAspectFit
        popOver()
    }
    
    func popOver() {
        view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    @IBAction func closeButtonDidPress(_ button: UIButton) {
        view.removeFromSuperview()
    }
    @IBAction func signInButtonDidPress(_ button: UIButton) {
        
        firebaseManager.emailLoginUserCreate(email: emailIdTextField.text ?? "name", password: passwordTextField.text ?? "password") { (msg) in
            if msg != "nil"{
                super.showAlert(title: "Failed", msg: msg, actionTitle: "Close")
                
            } else {
                self.view.removeFromSuperview()
                super.showAlert(title: "Success", msg: "Account has been created successfully", actionTitle: "Close")
            }
        }
        //view.removeFromSuperview()
    }
    
    @IBAction func gSignInButtonDidPress(_ button: UIButton) {
//        firebaseManager.
    }
}
