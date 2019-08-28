import Foundation

class URLInitializations {
    
    var baseURL: URL
    var httpMethod: HTTPMethod
    var httpHeaders: HTTPHeader
    var httpTask: HTTPTask
    
    init(url: URL, httpMethod: HTTPMethod, httpHeaders: HTTPHeader, httpTask: HTTPTask){
        self.baseURL = url
        self.httpMethod = httpMethod
        self.httpHeaders = httpHeaders
        self.httpTask = httpTask
    }
}
