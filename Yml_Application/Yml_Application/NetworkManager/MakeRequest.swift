import Foundation

typealias HTTPHeader = [String:String]
typealias Parameters = [String:String]
typealias HTTPBody = [String: Any]

enum HTTPMethod: String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum HTTPTask{

    case request
    case requestWithHeaders(header: HTTPHeader)
//    case requestWithHeaderAndBody(urlParameters: Parameters, headersToAdd: HTTPHeader?, bodyToAdd: HTTPBody?)
    case requestWithBody(httpBody: HTTPBody)

//    case request
//    case requestWithHeaders
//    case requestWithHeaderAndBody
//    case requestWithBody
}

class MakeRequest: MakeBaseRequest {
  
    private var task: URLSessionTask?
    
    static func performRequest(urlBase: URLInitializations, completion: @escaping (Data) -> Void) {
        
        var request = URLRequest(url: urlBase.baseURL)
        request.httpMethod = urlBase.httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        switch urlBase.httpTask{
            case .request: print(1)
            case .requestWithHeaders(let header):
                self.addHeaders(request: &request, httpHeader: header)
            case .requestWithBody(let httpBody):
                request.httpMethod = "POST"
            default: print(2)
        }
        let session = URLSession.shared.dataTask(with: request, completionHandler: { data,response,error in
                        if let error = error{
                            print(error)
                        }
                        if let data = data{
                            completion(data)
                        }
                    })
        session.resume()
    }
    
    static func addHeaders(request: inout URLRequest, httpHeader: HTTPHeader){
        for (key, value) in httpHeader{
            request.addValue(value, forHTTPHeaderField: key)
            print("\(key) \(value)")
        }
    }
}
