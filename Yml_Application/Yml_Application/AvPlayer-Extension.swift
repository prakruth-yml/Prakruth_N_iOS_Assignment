//
//  AvPlayer-Extension.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 27/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

extension AVPlayer {
    var isPlaying: Bool {
        if rate != 0{
            return true
        }
        return false
    }
}
