//
//  SprintDescriptionVC.swift
//  AgileSrintPlanner
//
//  Created by Prakruth Nagaraj on 18/09/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class SprintDescriptionVC: BaseVC {
    
    @IBOutlet private weak var startDateLabel: UILabel!
    @IBOutlet private weak var endDateLabel: UILabel!
    @IBOutlet private weak var availableStoriesTableView: UITableView!
    @IBOutlet private weak var toSelectStoriesTableView: UITableView!
    
    var viewModel: POViewModel?
    var index: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = viewModel?.sprintDetails[index ?? 0].title
        startDateLabel.text = viewModel?.sprintDetails[index ?? 0].startDate
        endDateLabel.text = viewModel?.sprintDetails[index ?? 0].endDate
        userSpecificUI()
    }
    
    @objc private func deleteSprintButtonDidPress() {
        print("cadsvasdv")
    }
    
    func userSpecificUI() {
        let role = UserDefaults.standard.object(forKey: Constants.UserDefaults.role) as? String ?? ""
        if(role == Roles.projectManager.rawValue) {
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-delete-16"), style: .plain, target: self, action: #selector(deleteSprintButtonDidPress))
        }
    }
}

extension SprintDescriptionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == availableStoriesTableView {
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == availableStoriesTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CurrentStroiesInSprintTVCell.self), for: indexPath) as? CurrentStroiesInSprintTVCell else { return CurrentStroiesInSprintTVCell() }
            
            cell.storyIDLabel.text = "c0"
            cell.storyTitleLabel.text = "cacsadvcds"
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AvailableSprintTVCell.self), for: indexPath) as? AvailableSprintTVCell else { return AvailableSprintTVCell() }
            
            cell.storyIDLabel.text = "c02"
            cell.storyTitleLabel.text = "cacsadvccadscsdcds"
            return cell
        }
    }
    
    
}
