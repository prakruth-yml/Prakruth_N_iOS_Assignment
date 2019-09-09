import Foundation
import Firebase
import FirebaseDatabase
import FirebaseUI

class POViewModel {
    
    var firebase = FirebaseManager()
    
    func addNewProject(title: String, domain: String, descp: String, completion: @escaping (() -> Void)){
        firebase.addNewProjectByPO(title: title, domain: domain, descp: descp, completion: completion)
    }
    
    func getProjectDetailsFromFM(completion: @escaping (([ProjectDetails]) -> Void)) {
        var detailsArr: [ProjectDetails] = []
        firebase.getProjectDetails { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let title = child.childSnapshot(forPath: Constants.FirebaseConstants.projectMembers).childSnapshot(forPath: Constants.FirebaseConstants.projectTitle).value as? String ?? ""
                let domain = child.childSnapshot(forPath: Constants.FirebaseConstants.projectMembers).childSnapshot(forPath: Constants.FirebaseConstants.projectDomain).value as? String ?? ""
                let descp = child.childSnapshot(forPath: Constants.FirebaseConstants.projectMembers).childSnapshot(forPath: Constants.FirebaseConstants.projectDescription
                    ).value as? String ?? ""
                let tempStruct = ProjectDetails(data: Data(title: title, domain: domain, descp: descp))
                detailsArr.append(tempStruct)
            }
            completion(detailsArr)
        }
    }
}
