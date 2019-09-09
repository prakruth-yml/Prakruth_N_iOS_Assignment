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
        static let rowsInBacklogs = 1
        static let rowsInTeam = 1
        enum Sections: Int {
            case description = 0
            case backlogs = 1
            case team = 2
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
    }
    
    struct AlertMessages {
        static let missingDataAlert = "Missing Data"
        static let tryAgainAction = "Try Again"
        static let successAlert = "Success"
        static let closeAction = "Close"
        static let failedLoginAlert = "Login Failed"
        static let errorAlert = "Error"
        static let userCreationFailedAlert = "User Creation Failed"
    }
    
    struct EmailValidation {
        static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    }
}
