//
//  CarrersVC.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 21/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit


class CarrersVC: UIViewController {

    @IBOutlet weak var videoPlayerView: UIView!
    @IBOutlet weak var playPauseButton: UIButton!
    var avPlayerView: AVPlayer = AVPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let ymlVideoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4") else { fatalError("No Video") }
        avPlayerView = AVPlayer(url: ymlVideoURL)
        let avPlayerLayer = AVPlayerLayer(player: avPlayerView)
        avPlayerLayer.frame = videoPlayerView.bounds
        videoPlayerView.layer.addSublayer(avPlayerLayer)
        let viewTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(mouseDidMoveOverView(_:)))
        viewTapGesture.minimumPressDuration = 1.0
        videoPlayerView.addGestureRecognizer(viewTapGesture)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayerView.pause()
    }
    
    @objc func mouseDidMoveOverView(_ sender: UILongPressGestureRecognizer){

        if avPlayerView.isPlaying{
            avPlayerView.pause()
        }
        else{
            avPlayerView.play()
        }
    }
}

extension AVPlayer {
    var isPlaying: Bool {
        if rate != 0{
            return true
        }
        return false
    }
}

//extension UIImageView{
//    
//    func loadImageFromURL2(url: URL) {
//        if let imageData = try? Data(contentsOf: url){
//            if let image = UIImage(data: imageData){
//                self.image = image
//            }
//        }
//    }
//}
