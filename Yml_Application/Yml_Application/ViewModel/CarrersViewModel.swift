//
//  CarrersViewModel.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 27/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import Foundation
class CarrersViewModel{

    var jsonItems: [JSONData] = []
    typealias jsonHandler = (() -> Void)
    typealias videoHandler = ((URL) -> Void)

    func loadPositionsFromJson(_ compHandler: @escaping jsonHandler){
        
        let urlStr = "http://jsonstub.com/positions"
        let userKey = "5b87065d-b207-44fc-aa26-b9e1253720d6"
        let projectKey = "9a5070e8-cd53-46d4-ae0a-c25f3458c81c"
        guard let url = URL(string: urlStr) else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(userKey, forHTTPHeaderField: "JsonStub-User-Key")
        request.addValue(projectKey, forHTTPHeaderField: "JsonStub-Project-Key")
        let session = URLSession.shared.dataTask(with: request, completionHandler: { data,response,error in
            if let error = error{
                print(error)
            }
            if let data = data{
                
                let jsonResponse = try? JSONDecoder().decode(Root.self, from: data)
                guard let jsonResponseDict = jsonResponse else { fatalError() }
                self.jsonItems = jsonResponseDict.data
                DispatchQueue.main.async {
                    compHandler()
                }
            }
        })
            session.resume()
        }
}

extension URLRequest {
//    func asyncDownload(completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()) {
//        URLSession.shared
//        .dataTask(with: self, completionHandler: completion)
//            .resume()
//    }
}


