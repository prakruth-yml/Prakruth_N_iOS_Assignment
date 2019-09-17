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
                weakSelf.isPresentUserInFirebase(email: email, completion: { (userPresence) in
                    if !userPresence {
                        weakSelf.ref.child(Constants.FirebaseConstants.employeeTable).child(user.uid).setValue([Constants.FirebaseConstants.empName: name, Constants.FirebaseConstants.empEmail: email, Constants.FirebaseConstants.empRole: "PO"])
                    }
                    completion(error)
                })
            }
        }
    }
    
    func isPresentUserInFirebase(email: String, completion: @escaping ((Bool) -> Void)) {
        ref.child(Constants.FirebaseConstants.employeeTable).observeSingleEvent(of: .value) { (snapshot) in
            guard let response = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            
            for child in response {
                let responseDict = child.value as? [String:String]
                print(responseDict?["emailId"])
                if email ==  responseDict?["emailId"] {
                    completion(true)
                    return 
                }
            }
            completion(false)
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
            guard let user = Auth.auth().currentUser,
                  let response = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            var role: String = ""
            for child in response {
                let responseDict = child.value as? [String:String]
                print("\(user.email) \(responseDict?["emailId"])")
                if user.email == responseDict?["emailId"] {
                    role = responseDict?["role"] ?? ""
                }
            }
            switch role {
            case Roles.developer.rawValue:
                let vc = UIStoryboard(name: "Main", bundle: nil)
                    .instantiateViewController(withIdentifier: String(describing: ProductOwnerMainVC.self))
                completion(vc, Roles.developer.rawValue)
            case Roles.projectManager.rawValue:
                let vc = UIStoryboard(name: "Main", bundle: nil)
                    .instantiateViewController(withIdentifier: String(describing: ProductOwnerMainVC.self))
                completion(vc, Roles.projectManager.rawValue)
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
//        let members: [String:String] = [poName : Constants.FirebaseConstants.poNameInAddProject]
        let members: [String:String] = [Constants.FirebaseConstants.poNameInAddProject : poName]
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
    func updateDetailsOfProject(projectName: String, updates: [String], completion: @escaping (() -> Void)) {
        var nonDevs: [String : Any] = [:]
        var devs: [String : String] = [:]
        ref.child(Constants.FirebaseConstants.ProjectTable.name).child(projectName).child(Constants.FirebaseConstants.ProjectTable.members).observeSingleEvent(of: .value) { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for child in snapshot {
                if child.key == Constants.FirebaseConstants.ProjectTable.developers {
                    guard let dev = child.children.allObjects as? [DataSnapshot] else { return }
                    
                    for eachDev in dev {
                        devs[eachDev.key] = eachDev.value as? String
                    }
                    nonDevs[Constants.FirebaseConstants.ProjectTable.developers] = devs
                } else {
                    nonDevs[child.key] = child.value as? String
                }
            }
            let data = [Constants.FirebaseConstants.projectTitle: updates[0], Constants.FirebaseConstants.projectDomain: updates[1], Constants.FirebaseConstants.projectDescription: updates[2]]
            let childUpdates = ["\(Constants.FirebaseConstants.projectsTable)/\(updates[0])/Data":data, "\(Constants.FirebaseConstants.projectsTable)/\(updates[0])/Members": nonDevs] as [String : Any]
            self.ref.updateChildValues(childUpdates)
            if projectName != updates[0] {
                self.ref.child(Constants.FirebaseConstants.ProjectTable.name).child(projectName).removeValue()
            }
            completion()
        }
    }

    /// Function to add a new team member to database
    ///
    /// - Parameters:
    ///   - projectName: name of the project
    ///   - member: the new team member to add
    ///   - completion: completion block
    func addNewTeamMemberToProject(projectName: String, member: [String : String], role: String?, email: String, completion: @escaping (() -> Void)) {
        ref.child(Constants.FirebaseConstants.ProjectTable.name).child(projectName).child(Constants.FirebaseConstants.ProjectTable.members).updateChildValues(member) { [weak self] (_, _) in
            var childUpdates: [String:String] = [:]
            for (key, value) in member {
                childUpdates = ["emailId": email, "name": value, "role": "PM"]
            }
            self?.ref.child(Constants.FirebaseConstants.employeeTable).childByAutoId().updateChildValues(childUpdates)
            completion()
        }
    }
    
    /// Removes the child from firebase table
    ///
    /// - Parameter name: name of child
    func deleteChild(name: String) {
        ref.child(Constants.FirebaseConstants.ProjectTable.name).child(name).removeValue()
    }
    
    /// Adds a new developer to the firebase database
    ///
    /// - Parameters:
    ///   - projectName: name of the project of the team member
    ///   - member: details of the member
    ///   - role: role of the member
    ///   - completion: completion Handler
    func addNewDeveloper(projectName: String, member: [String : String],completion: @escaping (() -> Void)) {
        ref.child(Constants.FirebaseConstants.ProjectTable.name).child(projectName).child(Constants.FirebaseConstants.ProjectTable.members).child(Constants.FirebaseConstants.ProjectTable.developers).updateChildValues(member) { [weak self] (_, _) in
            var childUpdates: [String:String] = [:]
            for (key, value) in member {
                childUpdates = ["emailId": value, "name": key, "role": "dev"]
            }
            self?.ref.child(Constants.FirebaseConstants.employeeTable).childByAutoId().updateChildValues(childUpdates)
            completion()
        }
    }
    
    /// Function to make an API call remove a team member from database
    ///
    /// - Parameters:
    ///   - projectName: The project to which the member belongs to
    ///   - teamMember: The team member to remove
    func removeTeamMember(projectName: String, teamMember: TeamMember) {
        
        if teamMember.role != Constants.FirebaseConstants.ProjectTable.developer {
        ref.child(Constants.FirebaseConstants.ProjectTable.name).child(projectName).child(Constants.FirebaseConstants.ProjectTable.members).child(teamMember.role).removeValue()
        } else {
        ref.child(Constants.FirebaseConstants.ProjectTable.name).child(projectName).child(Constants.FirebaseConstants.ProjectTable.members).child(Constants.FirebaseConstants.ProjectTable.developers).child(teamMember.name).removeValue()
        }
    }
    
    /// Function to add a new story to firebase database
    ///
    /// - Parameters:
    ///   - projectName: name of project
    ///   - story: the details of story to add
    ///   - completion: completion handle
    func addStory(projectName: String, story: [String], completion: @escaping ((Error?) -> Void)) {
        let storyRef = Constants.FirebaseConstants.ProjectTable.Stories.self
        let updateDetails = [storyRef.title: story[0], storyRef.summary: story[2], storyRef.description:story[3], storyRef.platform: story[4], storyRef.status: story[5]]
    ref.child(Constants.FirebaseConstants.ProjectTable.name).child(projectName).child(Constants.FirebaseConstants.ProjectTable.Stories.tableName).child(updateDetails[storyRef.title] ?? "").updateChildValues(updateDetails) { (error, _) in
        
            completion(error)
        }
    }
    
    func getStoryDetails(projectName: String, completion: @escaping SnapshotResponse) {
        ref.child(Constants.FirebaseConstants.ProjectTable.name).child(projectName).child(Constants.FirebaseConstants.ProjectTable.Stories.tableName).observeSingleEvent(of: .value) { (snapshot) in
            completion(snapshot)
        }
    }
    
    func removeStory(projectName: String, storyName: String) {
        ref.child(Constants.FirebaseConstants.ProjectTable.name).child(projectName).child(Constants.FirebaseConstants.ProjectTable.Stories.tableName).child(storyName).removeValue()
    }
}
