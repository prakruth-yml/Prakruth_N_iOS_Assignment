//
//  CarrersVC-Extension.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 27/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

extension CarrersVC {
    
    func playView(videoURL: String, view: UIView!) {
        guard let ymlVideoURL = URL(string: videoURL) else { fatalError("No Video") }
        avPlayerView = AVPlayer(url: ymlVideoURL)
        let avPlayerLayer = AVPlayerLayer(player: avPlayerView)
        avPlayerLayer.frame = videoPlayerView.bounds
        view.layer.addSublayer(avPlayerLayer)
        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(mouseDidTapView(_:)))
        view.addGestureRecognizer(viewTapGesture)
    }
}
