//
//  ContactUsViewModel.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 27/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import Foundation
class ContactUsViewModel{
    
    func getBangalore() -> Locations{
        return Locations(latitude: 12.9594, longitude: 77.6434, name: "Bangalore")
    }
    
    func getLa() -> Locations{
        return Locations(latitude: 37.5249, longitude: -122.2585, name: "Silicon Valley")
    }
    
    func getAtlanta() -> Locations{
        return Locations(latitude: 33.7490, longitude: 84.3880, name: "Atlanta")
    }
    
    func getIndianapolis() -> Locations{
        return Locations(latitude: 39.7684, longitude: 86.1581, name: "Indianapolis")
    }
}
