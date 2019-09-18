import UIKit

class SprintDisplayVC: BaseVC {
    
    @IBOutlet private weak var emptyWarningLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel: POViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = viewModel?.currentProject?.data.title ?? "" + " - Sprints"
        userSpecificUI()
        getAndReloadData()
    }
    
    func userSpecificUI() {
        guard let role = UserDefaults.standard.object(forKey: Constants.UserDefaults.role) as? String else { return }
        
        if role == Roles.projectManager.rawValue {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-plus-24"), style: .plain, target: self, action: #selector(addSprintButtonDidPress))
        }
    }
    
    func getAndReloadData() {
//        startLoading()
        viewModel?.getSprintDetails(projectName: viewModel?.currentProject?.data.title ?? "") { [weak self] in
            guard let self = self else { return }
                
            if self.viewModel?.sprintDetails.isEmpty ?? true {
                self.emptyWarningLabel.isHidden = false
//                self.stopLoading()
            } else {
                self.emptyWarningLabel.isHidden = true
            }
            self.collectionView.reloadData()
//            self.stopLoading()
        }
    }
    
    @objc private func addSprintButtonDidPress() {
        guard let newSprintVC = storyboard?.instantiateViewController(withIdentifier: String(describing: AddSprintVC.self)) as? AddSprintVC else { return }
        
        newSprintVC.viewModel = viewModel
        newSprintVC.callBack = { [weak self] in
            guard let self = self else { return }
            
            self.emptyWarningLabel.isHidden = true
            self.getAndReloadData()
        }
        addChild(newSprintVC)
        newSprintVC.view.frame = view.frame
        view.addSubview(newSprintVC.view)
        newSprintVC.didMove(toParent: self)
    }
}

extension SprintDisplayVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.sprintDetails.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SprintDisplayCVCell.self), for: indexPath) as? SprintDisplayCVCell else { return SprintDisplayCVCell() }
        
        cell.backgroundColor = UIColor.randomClr()
        cell.titleLabel.text = viewModel?.sprintDetails[indexPath.row].title
        cell.startDateLabel.text = viewModel?.sprintDetails[indexPath.row].startDate
        cell.endDateLabel.text = viewModel?.sprintDetails[indexPath.row].endDate
        cell.layer.cornerRadius = 7.0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsPerRow = CGFloat(2)
        let availableWidth = collectionView.frame.size.width - CGFloat(Constants.CollectionViewCell.leftSpacing)
        let widthPerItem = availableWidth / cellsPerRow
        return CGSize(width: widthPerItem, height: 192)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let sprintDescpVC = storyboard?.instantiateViewController(withIdentifier: String(describing: SprintDescriptionVC.self)) as? SprintDescriptionVC else { return }
        
        sprintDescpVC.viewModel = viewModel
        sprintDescpVC.index = indexPath.row
        navigationController?.pushViewController(sprintDescpVC, animated: true)
    }
}
