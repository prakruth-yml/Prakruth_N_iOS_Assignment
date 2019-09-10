struct ProjectDetails {
    var data: Data
    var teamMember: [TeamMember]
}

struct Data {
    var title: String
    var domain: String
    var descp: String
}

struct ProjectMembers {
    var data: TeamMember
}

struct TeamMember {
    var name: String
    var role: String
}

struct ProfileDetails {
    var name: String
    var role: String
    var email: String
}
