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
        
        let userKey = "5b87065d-b207-44fc-aa26-b9e1253720d6"
        let projectKey = "9a5070e8-cd53-46d4-ae0a-c25f3458c81c"
        
        guard let urlTemp = URL(string: "http://jsonstub.com/positions") else { fatalError() }
        let httpHeaders = ["Content-Type":"application/json", "JsonStub-User-Key": userKey, "JsonStub-Project-Key": projectKey]
        let urlInits = URLInitializations(url: urlTemp, httpMethod: HTTPMethod.get, httpHeaders: httpHeaders, httpTask: HTTPTask.requestWithHeaders(header: httpHeaders))
        
        MakeRequest.performRequest(urlBase: urlInits) { (data) in
            let jsonResponse = try? JSONDecoder().decode(Root.self, from: data)
            guard let jsonResponseDict = jsonResponse else { fatalError() }
            self.jsonItems = jsonResponseDict.data
            DispatchQueue.main.async {
                compHandler()
            }
        }
    }
}


