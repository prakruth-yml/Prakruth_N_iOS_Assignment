import Foundation
struct WorkTableViewData{
        
    let imageName: String
    let titleText: String
    let description: String
    let webUrl: String
        
    init(imageName: String, titleText: String, desc: String, webUrl: String){
        self.imageName = imageName
        self.titleText = titleText
        self.description = desc
        self.webUrl = webUrl
    }
}
