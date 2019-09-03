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

class EmailSignInPopUpVC: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
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
        
        firebaseManager.emailLoginUserCreate(email: emailIdTextField.text ?? "name", password: passwordTextField.text ?? "password") { (error) in
            if error != nil{
                self.errorLabel.isHidden = false
                self.errorLabel.text = error.localizedDescription
            } else {
                self.errorLabel.isHidden = true
                self.view.removeFromSuperview()
            }
        }
        view.removeFromSuperview()
    }
    
    @IBAction func gSignInButtonDidPress(_ button: UIButton){
//        firebaseManager.
    }
}
