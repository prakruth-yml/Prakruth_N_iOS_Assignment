import UIKit
import Firebase
import FirebaseDatabase
import FirebaseUI

class ProductBacklogsViewModel: BaseVM {
    
    let tableViewDataSource = [Constants.StoryDisplayTableView.textViewCell : ["Summary", "Dscription"], Constants.StoryDisplayTableView.pickerViewCell : ["Issue Type", "Platform"]]
    let pickerIssueTyeps = ["Story", "Task"]
    let pickerPlatforms = ["iOS", "Android", "Backend", "Frontend"]
    var newPlatformPicked: String = "iOS"
    var newTaskPicked: String = "Story"
    var storyDetailsToAdd: [String] = []
    var storyResponse: [Story]?
    let displayTitle = ["Issue Type", "Summary", "Description", "Platform", "Status"]
    var dataSrc: [String]?
    var storyDetails: Story?
    var currentStory: Story?
    var currentProject: ProjectDetails?
    
    func addStoryToFirebase(projectName: String, story: [String]?, completion: @escaping ErrorCompletionHandler) {
        firebase.addStory(projectName: projectName, story: story, completion: completion)
    }
    
    func getStoriesDetailsOfProject(projectName: String, completion: @escaping BaseCompletionHandler) {
        storyResponse?.removeAll()
        firebase.getStoryDetails(projectName: projectName) { [weak self] (snapshot) in
            guard let self = self,
                  let snapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            let storyRef = Constants.FirebaseConstants.ProjectTable.Stories.self
            snapshot.map({ (snapshot) in
                let title = snapshot.childSnapshot(forPath: storyRef.title).value as? String ?? ""
                let descp = snapshot.childSnapshot(forPath: storyRef.description).value as? String ?? ""
                let summary = snapshot.childSnapshot(forPath: storyRef.summary).value as? String ?? ""
                let platform = snapshot.childSnapshot(forPath: storyRef.platform).value as? String ?? ""
                let status = snapshot.childSnapshot(forPath: storyRef.status).value as? String ?? ""
                if self.storyResponse?.append(Story(title: title, summary: summary, description: descp, platform: platform, status: status)) == nil {
                    self.storyResponse = [Story(title: title, summary: summary, description: descp, platform: platform, status: status)]
                }
            })
            completion()
        }
    }
    
    func removeStory(projectName: String, storyName: String, completion: @escaping ErrorCompletionHandler) {
        firebase.removeStory(projectName: projectName, storyName: storyName, completion: completion)
    }
    
    func setCurrentStory(index: Int) {
        currentStory = storyResponse?[index]
    }
    
    func setStoryDescpDataSrc() {
        dataSrc = ["Story", currentStory?.summary, currentStory?.description, currentStory?.platform, currentStory?.status] as? [String]
    }
    
    func setCurrentProject(project: ProjectDetails?) {
        currentProject = project
    }
}
