import Foundation
import Firebase
import FirebaseDatabase
import FirebaseUI

class ProductBacklogsViewModel {
    
    var poViewModel = POViewModel()
    var firebase = FirebaseManager()
    let tableViewDataSource = [Constants.StoryDisplayTableView.textViewCell : ["Summary", "Dscription"], Constants.StoryDisplayTableView.pickerViewCell : ["Issue Type", "Platform"]]
    let pickerIssueTyeps = ["Story", "Task"]
    let pickerPlatforms = ["iOS", "Android", "Backend", "Frontend"]
    var newPlatformPicked: String = "iOS"
    var newTaskPicked: String = "Story"
    var storyDetailsToAdd: [String]?
    var storyResponse: [Story]?
    let displayTitle = ["Issue Type", "Summary", "Description", "Platform", "Status"]
    var dataSrc: [String]?
    var storyDetails: Story?
    
    func addStoryToFirebase(projectName: String, story: [String], completion: @escaping ((Error?) -> Void)) {
        firebase.addStory(projectName: projectName, story: story, completion: completion)
    }
    
    func getStoriesDetailsOfProject(projectName: String, completion: @escaping (() -> Void)) {
        storyResponse?.removeAll()
        firebase.getStoryDetails(projectName: projectName) { [weak self] (snapshot) in
            guard let self = self,
                  let snapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            let storyRef = Constants.FirebaseConstants.ProjectTable.Stories.self
            for child in snapshot {
                let title = child.childSnapshot(forPath: storyRef.title).value as? String ?? ""
                let descp = child.childSnapshot(forPath: storyRef.description).value as? String ?? ""
                let summary = child.childSnapshot(forPath: storyRef.summary).value as? String ?? ""
                let platform = child.childSnapshot(forPath: storyRef.platform).value as? String ?? ""
                let status = child.childSnapshot(forPath: storyRef.status).value as? String ?? ""
                if self.storyResponse?.append(Story(title: title, summary: summary, description: descp, platform: platform, status: status)) == nil {
                    self.storyResponse = [Story(title: title, summary: summary, description: descp, platform: platform, status: status)]
                }
            }
            completion()
        }
    }
    
    func removeStory(projectName: String, storyName: String) {
        firebase.removeStory(projectName: projectName, storyName: storyName)
    }
}
