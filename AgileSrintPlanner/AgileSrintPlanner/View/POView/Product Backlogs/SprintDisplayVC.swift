import UIKit

class SprintDisplayVC: BaseVC {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var emptyWarningLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel = POViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        navigationItem.title = viewModel.currentProjectName ?? "" + " - Sprints"
        //set hidden label
    }
    
    func userSpecificGUI() {
        guard let role = UserDefaults.standard.object(forKey: Constants.UserDefaults.role) as? String else { return }
        
        if role == Roles.projectManager.rawValue {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-plus-24"), style: .plain, target: self, action: #selector(addSprintButtonDidPress))
        }
    }
    
    @objc private func addSprintButtonDidPress() {
        
    }
}

//extension SprintDisplayVC: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SprintDisplayTVCell.self), for: indexPath) as? SprintDisplayTVCell else { return SprintDisplayTVCell() }
//
//        cell.titleLabel.text = "cac"
//        cell.startDateLabel.text = "cac"
//        cell.endDateLabel.text = "cdascsa"
//        return cell
//    }

extension SprintDisplayVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SprintDisplayCVCell.self), for: indexPath) as? SprintDisplayCVCell else { return SprintDisplayCVCell() }
        
        cell.backgroundColor = UIColor.randomClr()
        cell.titleLabel.text = "cac"
        cell.startDateLabel.text = "cac"
        cell.endDateLabel.text = "cdascsa"
        return cell
    }
    
    
}
