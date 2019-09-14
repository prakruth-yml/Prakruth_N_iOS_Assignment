//
//  StoriesDisplayVC.swift
//  AgileSrintPlanner
//
//  Created by Prakruth Nagaraj on 14/09/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class StoriesDisplayVC: BaseVC {
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-plus-24"), style: .plain, target: self, action: #selector(addStoryButtonDidPress))
    }
    
    @objc private func addStoryButtonDidPress(_ button: UIButton) {
        print("Clicked")
    }
}

extension StoriesDisplayVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StoriesDisplayTVCell.self), for: indexPath) as? StoriesDisplayTVCell else { return StoriesDisplayTVCell() }
        
        cell.storyIdLabel.text = "aa"
        cell.storyTitleLabel.text = "aa"
        cell.storyDescriptionLabel.text = "aa"
        cell.storyStatusLabel.text = "aa"
        return cell
    }
    
    
}
