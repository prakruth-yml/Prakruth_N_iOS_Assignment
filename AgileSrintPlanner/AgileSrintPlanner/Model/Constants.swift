enum Roles: String {
    case developer = "dev"
    case projectManager = "PM"
    case productOwner = "PO"
}

class Constants {
    struct  UserDefaults {
        static let currentUser = "currentUser"
        static let role = "role"
    }
}
