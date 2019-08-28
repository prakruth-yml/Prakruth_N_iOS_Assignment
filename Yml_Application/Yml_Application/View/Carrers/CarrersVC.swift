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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        viewModel.getData()
        viewModel.loadPositionsFromJson() { () -> Void in
            self.tableView.reloadData()
        }
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

extension CarrersVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return viewModel.jsonResponse.count
        return viewModel.jsonItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CarrersTableVIewCell.self)) as? CarrersTableVIewCell {
            cell.domain.text = viewModel.jsonItems[indexPath.row].domain
            cell.role.text = viewModel.jsonItems[indexPath.row].position
            cell.location.text = viewModel.jsonItems[indexPath.row].location
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
