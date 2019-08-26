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
    var avPlayerView: AVPlayer = AVPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let ymlVideoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4") else { fatalError("No Video") }
        avPlayerView = AVPlayer(url: ymlVideoURL)
        let avPlayerLayer = AVPlayerLayer(player: avPlayerView)
        avPlayerLayer.frame = videoPlayerView.bounds
        videoPlayerView.layer.addSublayer(avPlayerLayer)
        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(mouseDidTapView(_:)))
//        viewTapGesture.minimumPressDuration = 1.0
        videoPlayerView.addGestureRecognizer(viewTapGesture)
//        playPauseButton.imageView?.image = UIImage(named: "play")
//        playPauseButton.layer.zPosition = 1.0
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

extension AVPlayer {
    var isPlaying: Bool {
        if rate != 0{
            return true
        }
        return false
    }
}

extension CarrersVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CarrersTableVIewCell.self)) as? CarrersTableVIewCell {
            cell.domain.text = "New"
            cell.role.text = "ascawc"
            cell.location.text = "vasvasfbva"
            print(cell.domain.text)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
