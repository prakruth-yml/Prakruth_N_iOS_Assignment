import Foundation
import Firebase
import FirebaseDatabase
import FirebaseUI

class POViewModel {
    
    private var firebase = FirebaseManager()
    var projectDetails: [ProjectDetails]?
    var projectMembers: [ProjectMembers]?
    let headings = ["Title", "Domain", "Description"]
    let sectionHeading = ["Project Description", "Backlogs", "Team"]
    var editCondition = false
    var projectRolePicked: String?
    let productBacklog = ["Product Backlogs", "Sprints"]
    var currentProject: ProjectDetails?
    var sprintStartDate: String?
    var sprintEndDate: String?
    var currentSprint: Sprint?
    var sprintDetails: [Sprint] = []
    
    //API Call to firebase to add a new project
    //title: Title of Project; domain: Domain of project to be worked on; descp: Small description of the project; completion: Completion Handler
    func addNewProject(title: String, domain: String, descp: String, poName: String, completion: @escaping ((Error?) -> Void)) {
        firebase.addNewProjectByPO(title: title, domain: domain, descp: descp, poName: poName, completion: completion)
    }
    
    //API Call to firebase to fetch all project detals
    //completion: Completion Handler
    func getProjectDetailsFromFM(completion: @escaping (() -> Void)) {
        var detailsArr: [ProjectDetails] = []
        firebase.getProjectDetails { [weak self] (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot],
                  let weakSelf = self else { return }

            for child in snapshot {
                let title = child.childSnapshot(forPath: Constants.FirebaseConstants.projectMembers).childSnapshot(forPath: Constants.FirebaseConstants.projectTitle).value as? String ?? ""
                let domain = child.childSnapshot(forPath: Constants.FirebaseConstants.projectMembers).childSnapshot(forPath: Constants.FirebaseConstants.projectDomain).value as? String ?? ""
                let descp = child.childSnapshot(forPath: Constants.FirebaseConstants.projectMembers).childSnapshot(forPath: Constants.FirebaseConstants.projectDescription
                    ).value as? String ?? ""
                var teamMembers: [TeamMember] = []
                guard let member = child.childSnapshot(forPath: Constants.FirebaseConstants.ProjectTable.members).children.allObjects as? [DataSnapshot] else { return }
                for eachMember in member {
                    teamMembers.append(TeamMember(name: eachMember.value as? String ?? "", role: eachMember.key))
                }
                let projectStructure = ProjectDetails(data: Data(title: title, domain: domain, descp: descp), teamMember: teamMembers)
                detailsArr.append(projectStructure)
            }
            weakSelf.projectDetails = detailsArr
            completion()
        }
    }
    
    //API Call to firebase to get project details of current user
    //email: Current signed in user; completion: Completion Handle
    func getProjectDetailsForUserWith(userName: String, completion: @escaping (() -> Void)) {
        let email = userName
        var detailsArr: [ProjectDetails] = []
        firebase.getProjectDetails { [weak self] (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot],
                let weakSelf = self else { return }
            
            for child in snapshot {
                guard let member = child.childSnapshot(forPath: Constants.FirebaseConstants.ProjectTable.members).children.allObjects as? [DataSnapshot] else { return }
                
                if weakSelf.isUserPartOfTeam(email: email, projects: child.childSnapshot(forPath: Constants.FirebaseConstants.projectMembers).childSnapshot(forPath: Constants.FirebaseConstants.projectTitle), teamMembers: member) {
                    let title = child.childSnapshot(forPath: Constants.FirebaseConstants.projectMembers).childSnapshot(forPath: Constants.FirebaseConstants.projectTitle).value as? String ?? ""
                    let domain = child.childSnapshot(forPath: Constants.FirebaseConstants.projectMembers).childSnapshot(forPath: Constants.FirebaseConstants.projectDomain).value as? String ?? ""
                    let descp = child.childSnapshot(forPath: Constants.FirebaseConstants.projectMembers).childSnapshot(forPath: Constants.FirebaseConstants.projectDescription
                        ).value as? String ?? ""
                    var teamMembers: [TeamMember] = []
                    for eachMember in member {
                        print(eachMember)
                        if eachMember.key != Constants.FirebaseConstants.ProjectTable.developers {
                            teamMembers.append(TeamMember(name: eachMember.value as? String ?? "", role: eachMember.key))
                        } else {
                            guard let devs = eachMember.children.allObjects as? [DataSnapshot] else { return }
                            
                            print(devs)
                            for dev in devs {
                                print(dev)
                                teamMembers.append(TeamMember(name: dev.key as? String ?? "" , role: Constants.FirebaseConstants.ProjectTable.developer))
                            }
                        }
                    }
                    let projectStructure = ProjectDetails(data: Data(title: title, domain: domain, descp: descp), teamMember: teamMembers)
                    detailsArr.append(projectStructure)
                }
            }
            weakSelf.projectDetails = detailsArr
            completion()
        }
    }
    
    //Function to check if user is part of a team
    //email: Current User; projects: List of all projects; teamMembers: all Team members of the project
    func isUserPartOfTeam(email: String, projects: DataSnapshot, teamMembers: [DataSnapshot]) -> Bool {
        
        for member in teamMembers {
            if member.key != Constants.FirebaseConstants.ProjectTable.developers {
                if member.value as? String == email {
                    return true
                }
            } else {
                guard let devs = member.value as? [String:String] else { return true }
                
                for (key, _) in devs {
                    if key == email {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func updateDetailsOfProject(title: String, updateDetails: [String], completion: @escaping (() -> Void)) {
        firebase.updateDetailsOfProject(projectName: title, updates: updateDetails, completion: completion)
    }
    
    /// Removes the project from firebase table
    ///
    /// - Parameter projectName: name of project
    func removeProject(projectName: String) {
        firebase.deleteChild(name: projectName)
    }
    
    func addNewTeamMember(projectName: String, teamMember: [String : String], role: String?, completion: @escaping (() -> Void)) {
        firebase.addNewTeamMemberToProject(projectName: projectName, member: teamMember, role: role, completion: completion)
    }
    
    func addDeveloper(projectName: String, teamMember: ProfileDetails, completion: @escaping (() -> Void)) {
        firebase.addNewTeamMemberToProject2(projectName: projectName, member: teamMember, completion: completion)
    }
    
    func getDevelopersForProject(projectName: String) {
        
    }
    
    /// Function to remove a team member
    ///
    /// - Parameters:
    ///   - projectName: The project to which the member belongs to
    ///   - teamMember: The team member to remove
    func removeTeamMember(projectName: String, teamMember: TeamMember) {
        firebase.removeTeamMember(projectName: projectName, teamMember: teamMember)
    }
    
    func addSprint(projectName: String, sprint: Sprint?, completion: @escaping ((Error?) -> Void)) {
        guard let sprint = sprint else { return }
        firebase.addSprintToProject(projectName: projectName, sprint: sprint, completion: completion)
    }
    
    func setSprintStartDate(date: String) {
        sprintStartDate = date
    }
    
    func setSprintEndDate(date: String) {
        sprintEndDate = date
    }
    
    func setCurrentSprint(title: String, startDate: String, endDate: String) {
        currentSprint = Sprint(title: title, startDate: startDate, endDate: endDate)
    }
    
    func getSprintDetails(projectName: String, completion: @escaping (() -> Void)) {
        sprintDetails.removeAll()
        firebase.getSprintDetails(projectName: projectName) { [weak self] (snapshot) in
            print(snapshot)
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot],
               let self = self {
                for child in snapshot {
                    print(child)
                    guard let sprint = child.value as? [String:String] else { return }
                    
                    let title = sprint[Constants.FirebaseConstants.ProjectTable.Sprint.title]
                    let startData = sprint[Constants.FirebaseConstants.ProjectTable.Sprint.startDate]
                    let endData = sprint[Constants.FirebaseConstants.ProjectTable.Sprint.endDate]
                    self.sprintDetails.append(Sprint(title: title ?? "", startDate: startData ?? "", endDate: endData ?? ""))
                    
//                    for value in childSnapshot {
//                        print(value)
//                        let title = value.childSnapshot(forPath: Constants.FirebaseConstants.ProjectTable.Sprint.title).value as? String ?? ""
//                        let startData = value.childSnapshot(forPath: Constants.FirebaseConstants.ProjectTable.Sprint.startDate).value as? String ?? ""
//                        let endData = value.childSnapshot(forPath: Constants.FirebaseConstants.ProjectTable.Sprint.endDate).value as? String ?? ""
//                        self.sprintDetails.append(Sprint(title: title, startDate: startData, endDate: endData))
//                    }
                    print(self.sprintDetails)
                }
                completion()
            } else {
                completion()
            }
        }
    }
    
    func setCurrentProject(project: ProjectDetails?) {
        currentProject = project
    }
}
