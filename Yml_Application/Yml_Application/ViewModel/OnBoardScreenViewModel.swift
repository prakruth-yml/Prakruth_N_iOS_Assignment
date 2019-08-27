//
//  OnBoardScreenViewModel.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 27/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import Foundation
class OnBoardScreenViewModel{
    
    var onBoardScreenData: [OnboardScreenData] = []
    
    func getValues() {
        onBoardScreenData = [OnboardScreenData(bgName: "", productLogo: "", productTitle: "Hello", productDesc: "We are a design and innovation agency, creating digital products and experiences that have a lasting impact."), OnboardScreenData(bgName: "mobile-70", productLogo: "state-farm-logo", productTitle: "State Farm", productDesc: "All things insurance, all things banking, all in one app."), OnboardScreenData(bgName: "home-depot-mobile", productLogo: "thd-logo", productTitle: "The Home Depot", productDesc: "The ultimate power tool: A best-in-class digital experience for The Home Depot."), OnboardScreenData(bgName: "home-mob", productLogo: "paypal-logo", productTitle: "PayPal", productDesc: "Payment giant goes mobile-by-design."), OnboardScreenData(bgName: "molekule-mobile2", productLogo: "molekule", productTitle: "Molekule", productDesc: "he world's first intelligent air purifier, & the app putting clean air in people's hands.")]
    }
}
