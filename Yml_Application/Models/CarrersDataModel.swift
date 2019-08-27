import Foundation

struct Root: Decodable{
    let data: [JSONData]
}
struct JSONData: Decodable{
    let domain: String
    let position: String
    let location: String
}
