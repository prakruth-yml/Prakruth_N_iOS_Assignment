import UIKit

class StoriesDisplayVC: BaseVC {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var projectName: String?
    var viewModel = ProductBacklogsViewModel()
    weak var poViewModel: POViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userSpecificUI()
        navigationItem.title = "Stories"
        tableView.tableFooterView = UIView()
        getAndReloadData()
    }
    
    @objc private func addStoryButtonDidPress(_ button: UIButton) {
        guard let addStoryVC = storyboard?.instantiateViewController(withIdentifier: String(describing: AddNewStoryVC.self)) as? AddNewStoryVC else { return }
        
        addStoryVC.projectName = projectName
        addStoryVC.callBack = { [weak self] in
            guard let self = self else { return }
            
            self.getAndReloadData()
        }
        navigationController?.pushViewController(addStoryVC, animated: true)
    }
    
    func getAndReloadData() {
        startLoading()
        viewModel.getStoriesDetailsOfProject(projectName: projectName ?? "") { [weak self] in
            guard let self = self else { return }
            
            self.tableView.reloadData()
            self.stopLoading()
        }
    }
    
    private func userSpecificUI() {
        guard let role = UserDefaults.standard.object(forKey: Constants.UserDefaults.role) as? String else { return }
        
        if role == Roles.productOwner.rawValue {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-plus-24"), style: .plain, target: self, action: #selector(addStoryButtonDidPress))
        }
    }
}

extension StoriesDisplayVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.storyResponse?.count ?? Constants.NilCoalescingDefaults.int
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StoriesDisplayTVCell.self), for: indexPath) as? StoriesDisplayTVCell else { return StoriesDisplayTVCell() }
        
        cell.storyIdLabel.text = String(indexPath.row)
        cell.storyTitleLabel.text = viewModel.storyResponse?[indexPath.row].title
        cell.storyDescriptionLabel.text = viewModel.storyResponse?[indexPath.row].summary
        cell.storyStatusLabel.text = viewModel.storyResponse?[indexPath.row].status
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let role = UserDefaults.standard.object(forKey: Constants.UserDefaults.role) as? String else { return }
        
        if role == Roles.productOwner.rawValue {
            switch editingStyle {
            case .delete:
                guard let cell = tableView.cellForRow(at: indexPath) as? StoriesDisplayTVCell else { return }
                
                viewModel.removeStory(projectName: projectName ?? "", storyName: cell.storyTitleLabel.text ?? "") { [weak self] (error) in
                    guard let weakSelf = self, error == nil else {
                        self?.showAlert(title: Constants.AlertMessages.errorAlert, msg: error?.localizedDescription ?? "", actionTitle: Constants.AlertMessages.closeAction)
                        return
                    }
                    
                    weakSelf.getAndReloadData()
                }
            default:
                print("")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let storyDescpVC = storyboard?.instantiateViewController(withIdentifier: String(describing: StoriesDescriptionVC.self)) as? StoriesDescriptionVC else { return }
        
        storyDescpVC.storyDetails = viewModel.storyResponse?[indexPath.row]
        navigationController?.pushViewController(storyDescpVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
