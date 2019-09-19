import UIKit
import Firebase
import FirebaseDatabase
import FirebaseUI

class ProductOwnerMainVC: BaseVC {
    
    @IBOutlet private weak var emptyLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var addProjectButton: UIButton!

    private var viewModel = POViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getAndReloadData()
        userSpecificGUI()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon-user-acc"), style: .plain, target: self, action: #selector(userDisplayButtonDidPress))
        addProjectButton.imageView?.contentMode = .scaleToFill
    }
    
    /// Gets the Project Details of current user from firebase and refresh the collection view
    private func getAndReloadData() {
        startLoading()
        viewModel.getProjectDetailsForUserWith(userName: UserDefaults.standard.object(forKey: Constants.UserDefaults.currentUserName) as? String ?? "", completion: { [weak self] in
            guard let weakSelf = self else { return }
            
            if weakSelf.viewModel.projectDetails?.isEmpty ?? true {
                weakSelf.emptyLabel.isHidden = false
                self?.stopLoading()
            }
            weakSelf.collectionView.reloadData()
            weakSelf.stopLoading()
        })
    }
    
    /// Function to setup UI based on current user
    private func userSpecificGUI() {
        guard let role = UserDefaults.standard.object(forKey: Constants.UserDefaults.role) as? String else { return }
        
        switch role {
        case Roles.developer.rawValue, Roles.projectManager.rawValue:
            addProjectButton.isHidden = true
        default:
            print()
        }
    }

    @IBAction private func addButtonDidPress(_ button: UIButton) {
        guard let newProjectVC = storyboard?.instantiateViewController(withIdentifier: String(describing: NewProjectPopOverVC.self)) as? NewProjectPopOverVC else { return }
        
        newProjectVC.callback = { [weak self] in
            guard let self = self else { return }
            
            self.emptyLabel.isHidden = true
            self.getAndReloadData()
        }
        addChild(newProjectVC)
        newProjectVC.view.frame = view.frame
        view.addSubview(newProjectVC.view)
        newProjectVC.didMove(toParent: self)
    }
    
    @objc private func userDisplayButtonDidPress(_ button: UIButton) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: String(describing: AccDetailsVC.self)) as? AccDetailsVC else { return }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func projectDeleteButtonDIdTap(_ button: UIButton) {
        
        let closeAction = UIAlertAction(title: Constants.AlertMessages.closeAction, style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: Constants.AlertMessages.deleteAction, style: .destructive) { [weak self] (_) in
            guard let self = self else { return }
            
            let projectTitle = self.viewModel.projectDetails?[button.tag].data.title
            self.viewModel.removeProject(projectName: projectTitle ?? "") { (error) in
                if let error = error {
                    self.showAlert(title: Constants.AlertMessages.errorAlert, msg: error.localizedDescription, actionTitle: Constants.AlertMessages.closeAction)
                } else {
                    self.getAndReloadData()
                }
            }
        }
        showAlert(title: Constants.AlertMessages.confirmDelete, msg: Constants.AlertMessages.deleteMessage, alertStyle: .alert, actions: [closeAction, deleteAction])
    }
}

extension ProductOwnerMainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.projectDetails?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: POProductBacklogCVCell.self), for: indexPath) as? POProductBacklogCVCell
        cell?.titleOfProject.text = viewModel.projectDetails?[indexPath.row].data.title
        cell?.domainOfProject.text = viewModel.projectDetails?[indexPath.row].data.domain
        cell?.descriptionOfProject.text = viewModel.projectDetails?[indexPath.row].data.descp
        cell?.backgroundColor = UIColor.randomClr()
        cell?.layer.cornerRadius = 7.0
        if let userRole = UserDefaults.standard.object(forKey: Constants.UserDefaults.role) as? String {
            if userRole == Roles.productOwner.rawValue {
                cell?.projectDeleteButton.tag = indexPath.row
                cell?.projectDeleteButton.isHidden = false
                cell?.projectDeleteButton.addTarget(self, action: #selector(projectDeleteButtonDIdTap(_:)), for: .touchUpInside)
            }
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsPerRow = CGFloat(1)
        let availableWidth = collectionView.frame.size.width - CGFloat(Constants.CollectionViewCell.leftSpacing)
        let widthPerItem = availableWidth / cellsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: String(describing: ProjectDescriptionVC.self)) as? ProjectDescriptionVC else { return }
        
        viewController.projectDetails = viewModel.projectDetails?[indexPath.row]
        viewController.viewModel = viewModel
        viewController.index = indexPath.row
        viewModel.setCurrentProject(project: viewModel.projectDetails?[indexPath.row])
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension UIColor {
    
    static func randomClr() -> UIColor {
        return UIColor(red: CGFloat.random(in: 0.5...1), green: CGFloat.random(in: 0.5...1), blue: CGFloat.random(in: 0.5...1), alpha: 1.0)
    }
}
