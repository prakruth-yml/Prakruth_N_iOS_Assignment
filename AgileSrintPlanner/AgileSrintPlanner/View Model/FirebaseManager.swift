import Foundation
import Firebase
import FirebaseDatabase
import FirebaseUI

class FirebaseManager {

    private var ref = Database.database().reference()
    typealias SuccessHandler = ((_ error: Error?) -> Void)
    typealias SnapshotResponse = ((_ response: DataSnapshot) -> Void)
    
    func emailLoginUserCreate(name: String, email: String, password: String, completion: @escaping SuccessHandler) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (authRes, error) in
            guard let weakSelf = self else { return }
            
            if authRes != nil {
                guard let user = Auth.auth().currentUser else { return }
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = name
                changeRequest?.commitChanges { (error) in
                    if let error = error {
                        print(error)
                    }
                }
                weakSelf.ref.child(Constants.FirebaseConstants.employeeTable).child(user.uid).setValue([Constants.FirebaseConstants.empName: name, Constants.FirebaseConstants.empEmail: email, Constants.FirebaseConstants.empRole: "PO"])
            }
            completion(error)
        }
    }
    
    func emailUserLogin(email: String?, password: String?, completion: @escaping ((Any?, Error?) -> Void)) {
        guard let email = email,
              let password = password else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            completion(Auth.auth().currentUser as? User, error)
        }
    }
    
    func emailUserSignOut(completion: @escaping (() -> Void)) {
        try? Auth.auth().signOut()
        completion()
    }
    
    func decideUserRole(user: User?, completion: @escaping (UIViewController?, String) -> Void) {
        
        ref.child(Constants.FirebaseConstants.employeeTable).observeSingleEvent(of: .value) { (snapshot) in
            guard let user = Auth.auth().currentUser else { return }
            let role = snapshot.childSnapshot(forPath: user.uid).childSnapshot(forPath: Constants.FirebaseConstants.empRole).value as? String
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
                break
            }
        }
    }
    
    func getUserDetails(completion: @escaping ((_ profile: ProfileDetails) -> Void)) {
        ref.child(Constants.FirebaseConstants.employeeTable).observeSingleEvent(of: .value) { (snapshot) in
            guard let user = Auth.auth().currentUser else { return }
            
            completion(ProfileDetails(name: snapshot.childSnapshot(forPath: user.uid).childSnapshot(forPath: Constants.FirebaseConstants.empName).value as? String ?? "",
                                      role: snapshot.childSnapshot(forPath: user.uid).childSnapshot(forPath: Constants.FirebaseConstants.empRole).value as? String ?? "",
                                      email: snapshot.childSnapshot(forPath: user.uid).childSnapshot(forPath: Constants.FirebaseConstants.empEmail).value as? String ?? ""))
        }
    }
    
    func gmailLogin() {
    }
    
    func addNewProjectByPO(title: String, domain: String, descp: String, poName: String, completion: @escaping (() -> Void)) {
        guard let key = ref.child(Constants.FirebaseConstants.projectsTable).child(title).key else { return }
        let data = [Constants.FirebaseConstants.projectTitle: title, Constants.FirebaseConstants.projectDomain: domain, Constants.FirebaseConstants.projectDescription: descp]
        let members: [String:String] = [Constants.FirebaseConstants.poNameInAddProject: poName]
        let childUpdates = ["\(Constants.FirebaseConstants.projectsTable)/\(title)/Data":data, "\(Constants.FirebaseConstants.projectsTable)/\(title)/Members": members]
        ref.updateChildValues(childUpdates)
        completion()
    }
    
    func getProjectDetails(completion: @escaping SnapshotResponse) {
        ref.child(Constants.FirebaseConstants.ProjectTable.name).observeSingleEvent(of: .value) { (snapshot) in
            completion(snapshot)
        }
    }
    
    func getProjectTeam(project: String, completion: @escaping SnapshotResponse) {
        ref.child(Constants.FirebaseConstants.ProjectTable.name).child(project).child(Constants.FirebaseConstants.ProjectTable.members).observe(.value) { (snapshot) in
            completion(snapshot)
            print(snapshot)
        }
    }
    
    /// API Call to update details of project in firebase with name projectName
    ///
    /// - Parameters:
    ///   - projectName: name of project to update details.
    ///   - updates: array of updates of project details.
    ///   - members: array of updates of project members
    ///   - completion: completion handler
    func updateDetailsOfProject(projectName: String, updates: [String], members: [String : String], completion: @escaping (() -> Void)) {
        ref.child(Constants.FirebaseConstants.ProjectTable.name).child(projectName).removeValue()
        let data = [Constants.FirebaseConstants.projectTitle: updates[0], Constants.FirebaseConstants.projectDomain: updates[1], Constants.FirebaseConstants.projectDescription: updates[2]]
        let childUpdates = ["\(Constants.FirebaseConstants.projectsTable)/\(updates[0])/Data":data, "\(Constants.FirebaseConstants.projectsTable)/\(updates[0])/Members": members]
        ref.updateChildValues(childUpdates)
        completion()
    }
    
    /// Removes the child from firebase table
    ///
    /// - Parameter name: name of child
    func deleteChild(name: String) {
        ref.child(Constants.FirebaseConstants.ProjectTable.name).child(name).removeValue()
    }
}
