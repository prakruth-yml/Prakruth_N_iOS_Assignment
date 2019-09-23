import UIKit
import Firebase
import FirebaseDatabase
import FirebaseUI


class ProjectsDisplayVC: BaseVC {
    
    @IBOutlet private weak var emptyCellDisplayLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    private var viewModel = POViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getAndReloadData()
        userSpecificGUI()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon-user-acc"), style: .plain, target: self, action: #selector(userDisplayButtonDidPress))
        navigationItem.title = "Projects"
        tableView.register(UINib(nibName: String(describing: ProjectDisplayTVCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ProjectDisplayTVCell.self))
        if viewModel.projectDetails?.isEmpty == true {
            emptyCellDisplayLabel.isHidden = false
        }
        tableView.tableFooterView = UIView()
    }
    
    /// Gets the Project Details of current user from firebase and refresh the collection view
    private func getAndReloadData() {
        startLoading()
        viewModel.getProjectDetailsForUserWith(userName: UserDefaults.standard.object(forKey: Constants.UserDefaults.currentUserName) as? String ?? "", completion: { [weak self] in
            guard let weakSelf = self else { return }
            
            if weakSelf.viewModel.projectDetails?.isEmpty ?? true {
                weakSelf.emptyCellDisplayLabel.isHidden = false
                self?.stopLoading()
            }
            weakSelf.tableView.reloadData()
            weakSelf.stopLoading()
        })
    }
    
    /// Function to setup UI based on current user
    private func userSpecificGUI() {
        guard let role = UserDefaults.standard.object(forKey: Constants.UserDefaults.role) as? String else { return }
        
        switch role {
        case Roles.developer.rawValue, Roles.projectManager.rawValue:
            emptyCellDisplayLabel.text = "You are not assigned any projects as of now"
        case Roles.productOwner.rawValue:
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-plus-24"), style: .plain, target: self, action: #selector(addButtonDidPress))
        default:
            print()
        }
    }
    
    @objc private func userDisplayButtonDidPress(_ button: UIButton) {
        guard let viewController = UIStoryboard(name: Constants.MainStoryboard.name, bundle: nil).instantiateViewController(withIdentifier: String(describing: AccDetailsVC.self)) as? AccDetailsVC else { return }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func addButtonDidPress() {
        guard let newProjectVC = UIStoryboard(name: Constants.MainStoryboard.name, bundle: nil).instantiateViewController(withIdentifier: String(describing: NewProjectPopOverVC.self)) as? NewProjectPopOverVC else { return }
        
        newProjectVC.callback = { [weak self] in
            guard let self = self else { return }
            
            self.emptyCellDisplayLabel.isHidden = true
            self.getAndReloadData()
        }
        addChild(newProjectVC)
        newProjectVC.view.frame = view.frame
        view.addSubview(newProjectVC.view)
        newProjectVC.didMove(toParent: self)
    }
}

extension ProjectsDisplayVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.projectDetails?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProjectDisplayTVCell.self), for: indexPath) as? ProjectDisplayTVCell else { return ProjectDisplayTVCell() }
        
        cell.titleLabel.text = viewModel.projectDetails?[indexPath.row].data.title
        cell.domainLabel.text = viewModel.projectDetails?[indexPath.row].data.domain ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let role = UserDefaults.standard.object(forKey: Constants.UserDefaults.role) as? String else { return false }
        
        if role == Roles.productOwner.rawValue {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let role = UserDefaults.standard.object(forKey: Constants.UserDefaults.role) as? String else { return }
        
        if role == Roles.productOwner.rawValue {
            switch editingStyle {
            case .delete:
                  self.viewModel.removeProject(projectName: viewModel.projectDetails?[indexPath.row].data.title ?? "") { (error) in
                    if let error = error {
                        self.showAlert(title: Constants.AlertMessages.errorAlert, msg: error.localizedDescription, actionTitle: Constants.AlertMessages.closeAction)
                    } else {
                        self.getAndReloadData()
                    }
                }
            default:
                print("")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ProjectDescriptionVC.self)) as? ProjectDescriptionVC else { return }
        
        viewController.viewModel = viewModel
        viewController.index = indexPath.row
        viewModel.setCurrentProject(project: viewModel.projectDetails?[indexPath.row])
        navigationController?.pushViewController(viewController, animated: true)
    }
}
