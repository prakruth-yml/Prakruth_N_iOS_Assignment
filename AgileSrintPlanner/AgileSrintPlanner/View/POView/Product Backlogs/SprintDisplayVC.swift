import UIKit

class SprintDisplayVC: BaseVC {
    
    @IBOutlet private weak var emptyWarningLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel = POViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = viewModel.currentProjectName ?? "" + " - Sprints"
        userSpecificUI()
        //set hidden label
    }
    
    func userSpecificUI() {
        guard let role = UserDefaults.standard.object(forKey: Constants.UserDefaults.role) as? String else { return }
        
        if role == Roles.projectManager.rawValue {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-plus-24"), style: .plain, target: self, action: #selector(addSprintButtonDidPress))
        }
    }
    
    @objc private func addSprintButtonDidPress() {
        guard let newSprintVC = storyboard?.instantiateViewController(withIdentifier: String(describing: AddSprintVC.self)) as? AddSprintVC else { return }
        
//        newSprintVC.callBack = { [weak self] in
//            guard let self = self else { return }
//            
//            self.emptyLabel.isHidden = true
//            self.getAndReloadData()
//        }
        addChild(newSprintVC)
        newSprintVC.view.frame = view.frame
        view.addSubview(newSprintVC.view)
        newSprintVC.didMove(toParent: self)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SprintDisplayCVCell.self), for: indexPath) as? SprintDisplayCVCell else { return SprintDisplayCVCell() }
        
        cell.backgroundColor = UIColor.randomClr()
        cell.titleLabel.text = "cac"
        cell.startDateLabel.text = "cac"
        cell.endDateLabel.text = "cdascsa"
        cell.layer.cornerRadius = 7.0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsPerRow = CGFloat(2)
        let availableWidth = collectionView.frame.size.width - CGFloat(Constants.CollectionViewCell.leftSpacing)
        let widthPerItem = availableWidth / cellsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem / 2)
    }
}
