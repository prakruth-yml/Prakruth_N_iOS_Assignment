import UIKit

enum Roles: String {
    case developer = "dev"
    case projectManager = "PM"
    case productOwner = "PO"
}

class Constants {
    
    struct RolesFullForm {
        static let productOwner = "Product Owner"
        static let projectManager = "Project Manager"
        static let dev = "Developer"
    }
    
    struct  UserDefaults {
        static let currentUser = "currentUser"
        static let role = "role"
        static let currentUserName = "userName"
        static let currentUserId = "uid"
        static let currentUserEmail = "email"
    }
    
    struct  StickiesColor {
        static let yellow = ""
        static let blue = ""
        static let green = ""
        static let pink = ""
        static let purple = ""
        static let grey = ""
    }
    
    struct ProjectDescription {
        static let rowsInDescription = 3
        static let numberOfSections = 3
        static let rowsInBacklogs = 2
        static let rowsInTeam = 1
        enum Sections: Int {
            case description = 0
            case backlogs = 1
            case team = 2
        }
        enum BacklogButton: Int {
            case backlog = 0
            case sprint = 1
        }
    }
    
    struct  FirebaseConstants {

        static let employeeTable = "Employee"
        static let empName = "name"
        static let empEmail = "emailId"
        static let empRole = "role"
        static let projectsTable = "Projects"
        static let projectTitle = "Title"
        static let projectDomain = "Domain"
        static let projectDescription = "Descp"
        static let projectMembers = "Data"
        static let poNameInAddProject = "PO"
        struct ProjectTable {
            static let name = "Projects"
            static let data = "Data"
            static let members = "Members"
            static let developers = "Developers"
            static let developer = "Developer"
            struct Stories {
                static let tableName = "Stories"
                static let title = "Title"
                static let summary = "Summary"
                static let description = "Descp"
                static let platform = "Platform"
                static let status = "Backlog"
            }
            struct Sprint {
                static let tableName = "Sprints"
                static let title = "Title"
                static let startDate = "StartDate"
                static let endDate = "EndDate"
            }
        }
    }
    
    struct AlertMessages {
        static let missingDataAlert = "Missing Data"
        static let tryAgainAction = "Try Again"
        static let successAlert = "Success"
        static let closeAction = "Close"
        static let failedLoginAlert = "Login Failed"
        static let errorAlert = "Error"
        static let userCreationFailedAlert = "User Creation Failed"
        static let confirmChanges = "Confirm"
        static let checkAgain = "Discard"
        static let confirmMessage = "Are You sure you want to submit changes?"
        static let successUpdate = "Updates Successfully Made"
        static let deleteAction = "Delete"
        static let confirmDelete = "Confirm Delete"
        static let deleteMessage = "Are you sure you want to delete this project?"
        static let deleteMember = "Are you sure you want to delete this member?"
        static let poDeleteWarning = "Not Possible!"
        static let poDeleteMessage = "Can't remove Product Owner"
        static let storySuccess = "Story Added Successfully"
        static let sprintSuccess = "Sprint Added Successfully"
    }
    
    struct EmailValidation {
        static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let entiresMissing = "Email or Password Missing"
        static let entriesWrongFormat = "Email Wrongly Formatted"
        static let passwordsMismatch = "Passwords do not Match"
    }
    
    struct ProjectValidation {
        static let titleMissing = "Project Title is Mandatory"
        static let domainMissing = "Project Domain is Mandatory"
        static let descriptionMissing = "Project Description is Mandatory"
        static let success = "Project Created Successfully"
    }
    
    struct NotificationCenterNames {
        static let newProjectAdded = "newProjectAdded"
    }
    
    struct CollectionViewCell {
        static let leftSpacing = 20.0
    }
    
    struct NavigationBarConstants {
        static let editTitle = "Edit"
        static let doneTitle = "Done"
        static let cancelTitle = "Cancel"
    }
    
    struct CustomColor {
        static let tableViewSectionHeader = UIColor(red: 199 / 255, green: 210 / 255, blue: 216 / 255, alpha: 1.0)
    }
    
    struct POProjectsDescription {
        enum EditDetails {
            case canEdit
            case doneEdit
            
            var bool: Bool {
                switch self {
                case .canEdit:
                    return true
                default:
                    return false
                }
            }
        }
    }
    
    struct NilCoalescingDefaults {
        static let string = ""
        static let int = 0
        static let bool = true
    }
    
    struct YMLDomains {
        static let ios = "IOS"
        static let android = "Android"
        static let bk = "Back End"
        static let front = "Front End"
    }
    
    struct StoryDisplayTableView {
        static let numberOfRows = 4
        static let textViewCell = 0
        static let pickerViewCell = 1
        enum CellTag: Int {
            case issueType = 0
            case summary = 1
            case descp = 2
            case platform = 3
        }
        static let storyDescpNumRows = 4
    }
    
    struct MainStoryboard {
        static let name = "Main"
    }
}
