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
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = CarrersViewModel()
    var avPlayerView: AVPlayer = AVPlayer()
//    var jsonReturnData: [Data] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView.tableFooterView = UIView()
        viewModel.getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playView(videoURL: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4", view: videoPlayerView)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayerView.pause()
    }
    
    @objc func mouseDidTapView(_ sender: UITapGestureRecognizer){

        if avPlayerView.isPlaying{
            avPlayerView.pause()
        }
        else{
//            playPauseButton.isHidden = true
            avPlayerView.play()
        }
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
