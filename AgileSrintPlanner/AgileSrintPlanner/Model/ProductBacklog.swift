import Foundation

let storyTasks = ["Story", "Task"]
let ymlDomains = ["iOS", "Android", "Backend", "Front End"]

struct Story {
    var title: String
    var summary: String
    var description: String
    var platform: String
    var status: String
}

struct Sprint {
    var title: String
    var startDate: String
    var endDate: String
}
