import Foundation
import Firebase
import FirebaseDatabase
import FirebaseUI

class FirebaseManager {

    private var ref = Database.database().reference()
    typealias SuccessHandler = ((_ error: Error?) -> Void)
    typealias SnapshotResponse = ((_ response: DataSnapshot) -> Void)
    typealias BaseCompletionHandler = (() -> Void)
    typealias ErrorCompletionHandler = ((Error?) -> Void)
    
    /// Api call to create user with firebase autheticattion
    ///
    /// - Parameters:
    ///   - name: name of user to create
    ///   - email: email of the user
    ///   - password: password of the user
    ///   - completion: Completion block
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
                        weakSelf.ref.child(Constants.FirebaseConstants.employeeTable).child(name).setValue([Constants.FirebaseConstants.empName: name, Constants.FirebaseConstants.empEmail: email, Constants.FirebaseConstants.empRole: "PO"])
                    }
                    completion(error)
                })
            } else {
                completion(error)
            }
        }
    }
    
    /// Api call to check if user is already present in the database
    ///
    /// - Parameters:
    ///   - email: email of the user
    ///   - completion: Completion block
    func isPresentUserInFirebase(email: String, completion: @escaping ((Bool) -> Void)) {
        ref.child(Constants.FirebaseConstants.employeeTable).observeSingleEvent(of: .value) { (snapshot) in
            guard let response = snapshot.children.allObjects as? [DataSnapshot] else { return }
        
            let emailSearchResult = response.filter({ ($0.value as? [String: String])?[Constants.FirebaseConstants.empEmail] == email }).isEmpty
            completion(!emailSearchResult)
        }
    }
    
    /// Api call to autheticate user and login in to application
    ///
    /// - Parameters:
    ///   - email: email of the user
    ///   - password: password of the user
    ///   - completion: Completion Block
    func emailUserLogin(email: String?, password: String?, completion: @escaping ((Any?, Error?) -> Void)) {
        guard let email = email,
              let password = password else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            completion(Auth.auth().currentUser, error)
        }
    }
    
    /// Api call to sign out the current user
    func emailUserSignOut() {
         do {
            try Auth.auth().signOut()
        } catch {
            print("Couldn't Log out")
        }
    }
    
    /// Api call to check the role of the curretn user
    ///
    /// - Parameters:
    ///   - user: The current logged in user
    ///   - completion: Completion Handler
    func decideUserRole(user: User?, completion: @escaping (UIViewController?, String?) -> Void) {
        ref.child(Constants.FirebaseConstants.employeeTable).observeSingleEvent(of: .value) { (snapshot) in
            guard let user = Auth.auth().currentUser,
                  let response = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            let responseDict = response.filter({ ($0.value as? [String : String])?[Constants.FirebaseConstants.empEmail] == user.email })
            if responseDict.isEmpty {
                completion(nil, nil)
            } else {
                guard let role = (responseDict[0].value as? [String: String])?[Constants.FirebaseConstants.empRole] else { return }
                
                let projectsDisplayVC = ProjectsDisplayVC(nibName: "ProjectsDisplayVC", bundle: nil)
                let roleInSwitch = Roles(rawValue: role)
                switch roleInSwitch {
                case .developer?:
                    completion(projectsDisplayVC, Roles.developer.rawValue)
                case .projectManager?:
                    completion(projectsDisplayVC, Roles.projectManager.rawValue)
                case .productOwner?:
                    completion(projectsDisplayVC, Roles.productOwner.rawValue)
                default:
                    break
                }
            }
        }
    }
    
    /// Api call to retreive user details from firebase
    ///
    /// - Parameter completion: Completion handler
    func getUserDetails(completion: @escaping ((_ profile: ProfileDetails) -> Void)) {
        ref.child(Constants.FirebaseConstants.employeeTable).observeSingleEvent(of: .value) { (snapshot) in
            guard let user = Auth.auth().currentUser, let response = snapshot.children.allObjects as? [DataSnapshot] else { return }
        
            guard let child = response.filter({ ($0.value as? [String : String])?[Constants.FirebaseConstants.empEmail] == user.email })[0].value as? [String : String] else { return }
            
            completion(ProfileDetails(name: child[Constants.FirebaseConstants.empName] ?? "", role: Constants.FirebaseConstants.empRole ?? "", email: Constants.FirebaseConstants.empEmail ?? ""))
        }
    }
    
    /// Api call to add a new project to database
    ///
    /// - Parameters:
    ///   - title: Title of the project
    ///   - domain: domain of the project
    ///   - descp: description of the project
    ///   - poName: po name of the project
    ///   - completion: Completion Handler
    func addNewProjectByPO(title: String, domain: String, descp: String, poName: String, completion: @escaping SuccessHandler) {
        let data = [Constants.FirebaseConstants.projectTitle: title, Constants.FirebaseConstants.projectDomain: domain, Constants.FirebaseConstants.projectDescription: descp]
        let members: [String:String] = [Constants.FirebaseConstants.poNameInAddProject : poName]
        let childUpdates = ["\(Constants.FirebaseConstants.projectsTable)/\(title)/Data":data, "\(Constants.FirebaseConstants.projectsTable)/\(title)/Members": members]
        ref.updateChildValues(childUpdates) { (error, _) in
            DispatchQueue.main.async {
                completion(error)
            }
        }
    }
    
    /// Api call to get current project Details
    ///
    /// - Parameter completion: Completion Handler
    func getProjectDetails(completion: @escaping SnapshotResponse) {
        ref.child(Constants.FirebaseConstants.ProjectTable.name).observeSingleEvent(of: .value) { (snapshot) in
            DispatchQueue.main.async {
                completion(snapshot)
            }
        }
    }
    
    /// Function to get current project team members
    ///
    /// - Parameters:
    ///   - project: project Name
    ///   - completion: completion handler
    func getProjectTeam(project: String, completion: @escaping SnapshotResponse) {
        ref.child(Constants.FirebaseConstants.ProjectTable.name).child(project).child(Constants.FirebaseConstants.ProjectTable.members).observe(.value) { (snapshot) in
            completion(snapshot)
        }
    }
    
    /// API Call to update details of project in firebase with name projectName
    ///
    /// - Parameters:
    ///   - projectName: name of project to update details.
    ///   - updates: array of updates of project details.
    ///   - members: array of updates of project members
    ///   - completion: completion handler
    func updateDetailsOfProject(projectName: String, updates: [String], completion: @escaping BaseCompletionHandler) {
        var team: [String : Any] = [:]
        var devs: [String : String] = [:]
        ref.child(Constants.FirebaseConstants.ProjectTable.name).child(projectName).child(Constants.FirebaseConstants.ProjectTable.members).observeSingleEvent(of: .value) { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for child in snapshot {
                if child.key == Constants.FirebaseConstants.ProjectTable.developers {
                    guard let dev = child.children.allObjects as? [DataSnapshot] else { return }
                    
                    for eachDev in dev {
                        devs[eachDev.key] = eachDev.value as? String
                    }
                    team[Constants.FirebaseConstants.ProjectTable.developers] = devs
                } else {
                    team[child.key] = child.value as? String
                }
            }
            let data = [Constants.FirebaseConstants.projectTitle: updates[0], Constants.FirebaseConstants.projectDomain: updates[1], Constants.FirebaseConstants.projectDescription: updates[2]]
            let childUpdates = ["\(Constants.FirebaseConstants.projectsTable)/\(updates[0])/Data":data, "\(Constants.FirebaseConstants.projectsTable)/\(updates[0])/Members": team] as [String : Any]
            self.ref.updateChildValues(childUpdates, withCompletionBlock: { (_, _) in
                if projectName != updates[0] {
                    self.ref.child(Constants.FirebaseConstants.ProjectTable.name).child(projectName).removeValue()
                }
                DispatchQueue.main.async {
                    completion()
                }
            })
        }
    }

    /// Function to add a new team member to database
    ///
    /// - Parameters:
    ///   - projectName: name of the project
    ///   - member: the new team member to add
    ///   - completion: completion block
    func addNewTeamMemberToProject(projectName: String, member: ProfileDetails, completion: @escaping ErrorCompletionHandler) {
        let empChildUpdates = ["name": member.name, "role": member.role, "emailId": member.email]
        let switchItem = Roles(rawValue: member.role)
        switch switchItem {
        case .developer?:
            let projectChildUpdates = [member.name : member.email]
        ref.child(Constants.FirebaseConstants.ProjectTable.name).child(projectName).child(Constants.FirebaseConstants.ProjectTable.members).child(Constants.FirebaseConstants.ProjectTable.developers).updateChildValues(projectChildUpdates) { [weak self] (_, _) in
                guard let self = self else { return }
            
                self.ref.child(Constants.FirebaseConstants.employeeTable).child(member.name).updateChildValues(empChildUpdates) { (error, _) in
                    DispatchQueue.main.async {
                        completion(error)
                    }
                }
            }
        case .projectManager?:
            let projectChildUpdates = [member.role: member.name]
            ref.child(Constants.FirebaseConstants.ProjectTable.name).child(projectName).child(Constants.FirebaseConstants.ProjectTable.members).updateChildValues(projectChildUpdates) { [weak self] (_, _) in
                guard let self = self else { return }
            
                self.ref.child(Constants.FirebaseConstants.employeeTable).child(member.name).updateChildValues(empChildUpdates) { (error, _) in
                    DispatchQueue.main.async {
                        completion(error)
                    }
                }
            }
        default:
            print("")
        }
    }
    
    /// Removes the child from firebase table
    ///
    /// - Parameter name: name of child
    func deleteChild(name: String, completion: @escaping ErrorCompletionHandler) {
        ref.child(Constants.FirebaseConstants.ProjectTable.name).child(name).removeValue { (error, _) in
            DispatchQueue.main.async {
                completion(error)
            }
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
    func addStory(projectName: String, story: [String]?, completion: @escaping ErrorCompletionHandler) {
        let storyRef = Constants.FirebaseConstants.ProjectTable.Stories.self
        let updateDetails = [storyRef.title: story?[0] ?? "", storyRef.summary: story?[2] ?? "", storyRef.description:story?[3] ?? "", storyRef.platform: story?[4] ?? "", storyRef.status: story?[5] ?? ""]
    ref.child(Constants.FirebaseConstants.ProjectTable.name).child(projectName).child(Constants.FirebaseConstants.ProjectTable.Stories.tableName).child(updateDetails[storyRef.title] ?? "").updateChildValues(updateDetails) { (error, _) in
        
            DispatchQueue.main.async {
                completion(error)
            }
        }
    }
    
    /// API Call to fetch details of all stories in the project
    ///
    /// - Parameters:
    ///   - projectName: name of the project
    ///   - completion: commpletion handler
    func getStoryDetails(projectName: String, completion: @escaping SnapshotResponse) {
        ref.child(Constants.FirebaseConstants.ProjectTable.name).child(projectName).child(Constants.FirebaseConstants.ProjectTable.Stories.tableName).observeSingleEvent(of: .value) { (snapshot) in
            DispatchQueue.main.async {
                completion(snapshot)
            }
        }
    }
    
    func removeStory(projectName: String, storyName: String, completion: @escaping ErrorCompletionHandler) {
        ref.child(Constants.FirebaseConstants.ProjectTable.name).child(projectName).child(Constants.FirebaseConstants.ProjectTable.Stories.tableName).child(storyName).removeValue { (error, _) in
            DispatchQueue.main.async {
                completion(error)
            }
        }
    }
    
    /// Function to add a sprint to database
    ///
    /// - Parameters:
    ///   - projectName: Name of project
    ///   - sprint: Sprint to add
    func addSprintToProject(projectName: String, sprint: Sprint, completion: @escaping ErrorCompletionHandler) {
        let tableRef = Constants.FirebaseConstants.ProjectTable.Sprint.self
        let childUpdates = [tableRef.title : sprint.title, tableRef.startDate: sprint.startDate, tableRef.endDate: sprint.endDate]
        ref.child(Constants.FirebaseConstants.ProjectTable.name).child(projectName).child(Constants.FirebaseConstants.ProjectTable.Sprint.tableName).child(sprint.title).updateChildValues(childUpdates) { (error, _) in
            DispatchQueue.main.async {
                completion(error)
            }
        }
    }
    
    /// API Call to fetch details fo the current project sprint details
    ///
    /// - Parameters:
    ///   - projectName: current project name
    ///   - completion: completion handler
    func getSprintDetails(projectName: String, completion: @escaping SnapshotResponse) {
        ref.child(Constants.FirebaseConstants.ProjectTable.name).child(projectName).child(Constants.FirebaseConstants.ProjectTable.Sprint.tableName).observeSingleEvent(of: .value) { (snapshot) in
            DispatchQueue.main.async {
                completion(snapshot)
            }
        }
    }
}
