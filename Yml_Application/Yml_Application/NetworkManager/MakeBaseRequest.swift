import Foundation

protocol MakeBaseRequest {
    typealias completionHandler = (_ data: Data, _ response: URLResponse, _ error: Error) -> ()
    static func performRequest(urlBase: URLInitializations, completion: @escaping (Data) -> Void)
}
