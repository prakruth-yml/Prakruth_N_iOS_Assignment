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
    var jsonReturnData: [Data] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView.tableFooterView = UIView()
        getData()
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
        return jsonReturnData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CarrersTableVIewCell.self)) as? CarrersTableVIewCell {
            cell.domain.text = "New"
            cell.role.text = "ascawc"
            cell.location.text = "vasvasfbva"
            print(cell.domain.text)
            
            cell.domain.text = jsonReturnData[indexPath.row].domain
            cell.role.text = jsonReturnData[indexPath.row].role
            cell.location.text = jsonReturnData[indexPath.row].location
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension CarrersVC{
    struct Root: Decodable{
        let data: [Data]
    }
    
    struct Data: Decodable{
        let domain: String
        let role: String
        let location: String
    }
    
    func getData() {
        let urlStr = "http://jsonstub.com/positions"
        guard let url = URL(string: urlStr) else { fatalError() }
        var request = URLRequest(url: url)
        let userKey = "5b87065d-b207-44fc-aa26-b9e1253720d6"
        let projectKey = "9a5070e8-cd53-46d4-ae0a-c25f3458c81c"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(userKey, forHTTPHeaderField: "JsonStub-User-Key")
        request.addValue(projectKey, forHTTPHeaderField: "JsonStub-Project-Key")
        
        let session = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error{
                print(error)
            }
            if let response = response, let data = data{
                let mainData = try? JSONDecoder().decode(Root.self, from: data)
                let data = mainData?.data
                self.jsonReturnData = data!
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
            }
            })
        session.resume()
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
