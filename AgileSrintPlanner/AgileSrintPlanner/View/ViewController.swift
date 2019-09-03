//
//  ViewController.swift
//  AgileSrintPlanner
//
//  Created by Prakruth Nagaraj on 30/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit
import Firebase
import Crashlytics

class ViewController: UIViewController {
    
    @IBOutlet weak var gSignInButton: UIButton!
    @IBOutlet weak var emailSignInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordextField: UITextField!
//    let temp = FirebaseApp.configure()
//    var db = Firestore.firestore()
//    var ref: DatabaseReference!
//
    override func viewDidLoad() {
        super.viewDidLoad()
        gSignInButton.imageView?.contentMode = .scaleAspectFit
        emailSignInButton.imageView?.contentMode = .scaleAspectFit
        
        
        
//        let db = Firestore.firestore()
//        db.collection("Test").getDocuments(completion: {(querySnaps, error) in
//            if let err = error{
//                print(err)
//            }
//            else{
//                for document in querySnaps!.documents {
//                    print("\(document.documentID) \(document.data())")
//                }
//            }
//            })
        
//        ref = Database.database().reference()
//        self.ref.child("users").child(user.uid).setValue(["username": "username"])
//        ref.child("Test").child("Test").setValue("Prakruth N", forKey: "Name")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func newUserButtonDidPress(_ button: UIButton) {
        guard let popVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: EmailSignInPopUpVC.self)) as? EmailSignInPopUpVC else { fatalError() }
        self.addChild(popVC)
        popVC.view.frame = view.frame
        view.addSubview(popVC.view)
        popVC.didMove(toParent: self)
    }
    
    @IBAction func duttonDidPress(_ button: UIButton) {
//        var ref: DocumentReference = db.collection("Test").addDocument(data: ["name": "Bought Something", "fullName": "Bought something else"]) { err in
//            if let err = err{
//                print("Error")
//            }
//            else{
//                print("Added")
//            }
//        }
//        let db2 = Database.database().reference().child("Testing")
//        let mesg = ["Sender": "Names", "msgBody": "Hello"]
//        db2.childByAutoId().setValue(mesg) { (error, ref) in
//            if error != nil{
//                print(error)
//            }
//            else{
//                print("YES")
//            }
//        }
        Crashlytics.sharedInstance().crash()
    }


}

