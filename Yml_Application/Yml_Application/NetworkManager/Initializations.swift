import Foundation

typealias HTTPHeader = [String:String]
typealias Parameters = [String:String]
typealias HTTPBody = [String: Any]

protocol URLInitializations {
    
    var baseURL: URL { get }
    var httpMethod: HTTPMethod { get }
    var httpHeaders: HTTPHeader? { get }
    var httpTask: HTTPTask { get }
}

enum HTTPMethod: String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum HTTPTask{

    case request
    case requestWithHeaders(urlBase: URLInitializations)
//    case requestWithHeaderAndBody(urlParameters: Parameters, headersToAdd: HTTPHeader?, bodyToAdd: HTTPBody?)
//    case requestWithBody(urlBase: URLInitializations)

//    case request
//    case requestWithHeaders
//    case requestWithHeaderAndBody
//    case requestWithBody
}

protocol MakeBaseRequest {
    typealias completionHandler = (_ data: Data, _ response: URLResponse, _ error: Error) -> ()
    func performRequest(urlBase: URLInitializations, completion: @escaping completionHandler)
//    func performRequestWithHeader(urlBase)
}

class MakeRequest: MakeBaseRequest {
    
    private var task: URLSessionTask?
    
    func performRequest(urlBase: URLInitializations, completion: @escaping completionHandler) {
        
        var request = URLRequest(url: urlBase.baseURL)
        request.httpMethod = urlBase.httpMethod.rawValue
        switch urlBase.httpTask{
            case .request: print(1)
            case .requestWithHeaders(let urlBase):
                self.addHeaders(request: &request, httpHeader: urlBase.httpHeaders)
            default: print(2)
        }
        
        let session = URLSession()
        
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data, response: URLResponse, error: Error) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                completion(data, response, error)
            })
            } as! (Data?, URLResponse?, Error?) -> Void)
        
        task.resume()
    }
    
    func addHeaders(request: inout URLRequest, httpHeader: HTTPHeader?){
        guard let httpHeader = httpHeader else { fatalError() }
        for (key, value) in httpHeader{
            request.addValue(key, forHTTPHeaderField: value)
        }
    }
}
