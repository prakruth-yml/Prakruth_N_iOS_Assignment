class POViewModel {
    
    var firebase = FirebaseManager()
    
    func addNewProject(title: String, domain: String, descp: String, completion: @escaping (() -> Void)){
        firebase.addNewProjectByPO(title: title, domain: domain, descp: descp, completion: completion)
    }
}
