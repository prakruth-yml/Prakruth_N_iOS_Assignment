import Foundation
import Firebase
import FirebaseDatabase
import FirebaseUI

class FirebaseManager {

    var ref = Database.database().reference()
    var authResult: NSError!
    typealias  SuccessHandler = ((String) -> Void)
    
    func emailLoginUserCreate(email: String, password: String, completion: @escaping SuccessHandler) {
        Auth.auth().createUser(withEmail: email, password: password) { (authRes, error) in
            var successMsg: String = "nil"
            if let err = error {
                successMsg = err.localizedDescription
            }
            if let authRes = authRes {
                guard let user = Auth.auth().currentUser else { fatalError() }
                self.ref.child("Employee").child("\(user.uid)").setValue(["emailId": email, "role": "PM"])
            }
            completion(successMsg)
        }
    }
    
    func emailUserLogin(email: String?, password: String?, completion: @escaping ((Any, String) -> Void)) {
        guard let email = email else { fatalError() }
        guard let password = password else { fatalError() }
        var msg = "nil"
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            guard let strongSelf = self else { return }
            if let error = error {
                msg = error.localizedDescription
            }
            completion(Auth.auth().currentUser as? User, msg)
        }
    }
    
    func decideUserRole(user: User?, completion: @escaping (UIViewController?) -> Void) {
        
        ref.child("Employee").observeSingleEvent(of: .value) { (snapshot) in
            guard let user = Auth.auth().currentUser else { fatalError() }
            let role = snapshot.childSnapshot(forPath: user.uid).childSnapshot(forPath: "role").value as? String
            switch role {
            case Roles.developer.rawValue: print("Dev")
            case Roles.projectManager.rawValue: print("PM")
            case Roles.productOwner.rawValue:
                let vc = UIStoryboard(name: "Main", bundle: nil)
                    .instantiateViewController(withIdentifier: String(describing: ProductOwnerMainVC.self))
                    as? ProductOwnerMainVC
                completion(vc)
            default: print("NO ROle")
            }
        }
    }
    
    func gmailLogin() {
    }
}
