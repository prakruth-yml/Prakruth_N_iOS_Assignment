import Foundation

struct ResponseFromJSON: Decodable{
    let data: [CarrersData]
}

struct CarrersData: Decodable{
    let domain: String
    let role: String
    let location: String
}
