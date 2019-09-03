import Foundation
import Firebase
import FirebaseDatabase
import FirebaseUI

class FirebaseManager{
    
    var ref = Database.database().reference()
    var authResult: NSError!
    typealias  SuccessHandler = ((Error) -> Void)
    
    func emailLoginUserCreate(email: String, password: String, completion: @escaping SuccessHandler) {
        Auth.auth().createUser(withEmail: email, password: password) { (authRes, error) in
            if let error = error{
                completion(error)
            }
            if let authRes = authRes {
                self.ref.child("Employee").childByAutoId().setValue(["emailId": email, "role": "PM"])
            }
        }
    }
    
    func gmailLogin() {
    }
}
