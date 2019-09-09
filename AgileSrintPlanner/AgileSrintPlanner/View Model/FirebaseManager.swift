import Foundation
import Firebase
import FirebaseDatabase
import FirebaseUI

class FirebaseManager {

    var ref = Database.database().reference()
    var authResult: NSError!
    typealias SuccessHandler = ((Error?) -> Void)
    
    func emailLoginUserCreate(name: String, email: String, password: String, completion: @escaping SuccessHandler) {
        Auth.auth().createUser(withEmail: email, password: password) { (authRes, error) in
            if let err = error {
                completion(err)
            }
            if authRes != nil {
                guard let user = Auth.auth().currentUser else { fatalError() }
                
                self.ref.child(Constants.FirebaseConstants.employeeTable).child("\(user.uid)").setValue([Constants.FirebaseConstants.empName: name, Constants.FirebaseConstants.empEmail: email, Constants.FirebaseConstants.empRole: "PO"])
            }
            completion(nil)
        }
    }
    
    func emailUserLogin(email: String?, password: String?, completion: @escaping ((Any?, Error?) -> Void)) {
        guard let email = email,
              let password = password else { fatalError() }
        
        var msg = "nil"
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error {
                completion(nil, error)
            }
            completion(Auth.auth().currentUser as? User, nil)
        }
    }
    
    func emailUserSignOut(completion: @escaping (() -> Void)) {
        
        try? Auth.auth().signOut()
        completion()
    }
    
    func decideUserRole(user: User?, completion: @escaping (UIViewController?, String) -> Void) {
        
        ref.child(Constants.FirebaseConstants.employeeTable).observeSingleEvent(of: .value) { (snapshot) in
            guard let user = Auth.auth().currentUser else { fatalError() }
            let role = snapshot.childSnapshot(forPath: user.uid).childSnapshot(forPath: Constants.FirebaseConstants.empRole).value as? String
            var roleStr: String
            switch role {
            case Roles.developer.rawValue:
                print("Dev")
            case Roles.projectManager.rawValue:
                print("PM")
            case Roles.productOwner.rawValue:
                let vc = UIStoryboard(name: "Main", bundle: nil)
                    .instantiateViewController(withIdentifier: String(describing: ProductOwnerMainVC.self))
                completion(vc, Roles.productOwner.rawValue)
            default:
                print("NO ROle")
            }
        }
    }
    
    func getUserDetails(completion: @escaping ((String, String, String) -> Void)) {
        ref.child(Constants.FirebaseConstants.employeeTable).observeSingleEvent(of: .value) { (snapshot) in
            guard let user = Auth.auth().currentUser else { fatalError() }
            completion(snapshot.childSnapshot(forPath: user.uid).childSnapshot(forPath: Constants.FirebaseConstants.empName).value as? String ?? "",
                       snapshot.childSnapshot(forPath: user.uid).childSnapshot(forPath: Constants.FirebaseConstants.empEmail).value as? String ?? "",
                       snapshot.childSnapshot(forPath: user.uid).childSnapshot(forPath: Constants.FirebaseConstants.empRole).value as? String ?? "")
        }
    }
    
    func gmailLogin() {
    }
    
    func addNewProjectByPO(title: String, domain: String, descp: String, completion: @escaping (() -> Void)) {
        guard let key = ref.child(Constants.FirebaseConstants.projectsTable).childByAutoId().key else { fatalError() }
        let data = [Constants.FirebaseConstants.projectTitle: title, Constants.FirebaseConstants.projectDomain: domain, Constants.FirebaseConstants.projectDescription: descp]
        let members: [String:String] = [:]
//        let childUpdates = ["/Projects/\(key)/Data":data, "/Projects/\(key)/Members": members]
        let childUpdates = ["\(Constants.FirebaseConstants.projectsTable)/\(key)/Data":data, "\(Constants.FirebaseConstants.projectsTable)/\(key)/Members": members]
        ref.updateChildValues(childUpdates)
        completion()
    }
    
    func getProjectDetails(completion: @escaping ((DataSnapshot) -> Void)) {
        var detailsArr: [ProjectDetails] = []
        ref.child(Constants.FirebaseConstants.projectsTable).observeSingleEvent(of: .value) { (snapshot) in
            print(snapshot.childrenCount)
            completion(snapshot)
        }
    }
}
