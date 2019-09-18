import UIKit

class ProjectDescriptionVC: BaseVC {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var newUserButton: UIButton!
    @IBOutlet private weak var actualView: UIView!
    
    var projectDetails: ProjectDetails?
    var projectDetailsArr: [String] = []
    var updateDetails: [String] = []
    var viewModel: POViewModel?
    var index: Int?
    var teamMembersToRemove: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userSpecificUI()
        projectDetailsArr = [projectDetails?.data.title, projectDetails?.data.domain, projectDetails?.data.descp] as? [String] ?? [""]
        navigationItem.title = viewModel?.projectDetails?[index ?? 0].data.title
        tableView.tableFooterView = UIView()
        newUserButton.layer.cornerRadius = newUserButton.imageView?.frame.width ?? 1.0 / 2
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let touch: UITouch? = touches.first
        if touch?.view != actualView {
            view.removeFromSuperview()
        }
    }
    
    /// Function to fetch and reload the UI
    ///
    /// - Parameter projectName: name of the current project
    private func getAndReloadData(projectName: String) {
        viewModel?.getProjectDetailsForUserWith(userName: UserDefaults.standard.object(forKey: Constants.UserDefaults.currentUserName) as? String ?? "", completion: { [weak self] in
            guard let self = self else { return }
         
            self.getCurrentProjectDetails(projectName: projectName)
            self.projectDetailsArr = [self.projectDetails?.data.title, self.projectDetails?.data.domain, self.projectDetails?.data.descp] as? [String] ?? [""]
            self.navigationItem.title = self.projectDetailsArr.first
            self.tableView.reloadData()
            guard let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: Constants.ProjectDescription.Sections.team.rawValue)) as? TeamMembersTVCell else { return }
            
            cell.collectionView.reloadData()
        })
    }
    
    private func getCurrentProjectDetails(projectName: String) {
        guard let projectDetailsToSearch = viewModel?.projectDetails else { return }
        
        for project in projectDetailsToSearch {
            if project.data.title == projectName {
                projectDetails = project
                return
            }
        }
    }
    
    //Edit button action function
    @objc func editNavBarItemDidPress() {
        if viewModel?.editCondition == false {
            viewModel?.editCondition = true
            newUserButton.isHidden = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.NavigationBarConstants.doneTitle, style: .done, target: self, action: #selector(editNavBarItemDidPress))
            navigationItem.hidesBackButton = true
            guard let tvCell = tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? TeamMembersTVCell else { return }
            
            tvCell.collectionView.reloadData()
    
            self.tableView.reloadData()
        } else {
            updateDetails.removeAll()
            for row in 0..<Constants.ProjectDescription.rowsInDescription {
                guard let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? ProjectDescriptionTVCell else { return }
            
                updateDetails.append(cell.textToDisplay.text)
            }
            viewModel?.editCondition = false
            newUserButton.isHidden = true
            guard let tvCell = tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? TeamMembersTVCell else { return }
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.NavigationBarConstants.editTitle, style: .plain, target: self, action:
                #selector(editNavBarItemDidPress))
            navigationItem.hidesBackButton = false
            let confirmAction = UIAlertAction(title: Constants.AlertMessages.confirmChanges, style: .default) { [weak self] (_) in
                guard let self = self,
                      let poName = UserDefaults.standard.object(forKey: Constants.UserDefaults.currentUserName) as? String,
                      let projectDetails = self.projectDetails else { return }
                
                self.startLoading()
                for index in self.teamMembersToRemove {
                    self.viewModel?.removeTeamMember(projectName: self.projectDetailsArr[0], teamMember: projectDetails.teamMember[index])
                }
                self.teamMembersToRemove.removeAll()
                self.viewModel?.updateDetailsOfProject(title: self.projectDetailsArr.first ?? Constants.NilCoalescingDefaults.string, updateDetails: self.updateDetails) { [weak self] in
                    guard let self = self else { return }
                    
                    self.getAndReloadData(projectName: self.updateDetails[0])
                    self.stopLoading()
                    self.showAlert(title: Constants.AlertMessages.successAlert, msg: Constants.AlertMessages.successUpdate, actionTitle: Constants.AlertMessages.closeAction)
                }
                tvCell.collectionView.reloadData()
            }
            let declineAction = UIAlertAction(title: Constants.AlertMessages.checkAgain, style: .cancel) { [weak self] (_) in
                guard let self = self,
                    let poName = UserDefaults.standard.object(forKey: Constants.UserDefaults.currentUserName) as? String else { return }

                self.startLoading()
                self.getAndReloadData(projectName: self.projectDetailsArr.first ?? Constants.NilCoalescingDefaults.string)
                self.stopLoading()
            }
            showAlert(title: Constants.AlertMessages.confirmChanges, msg: Constants.AlertMessages.confirmMessage, alertStyle: .alert, actions: [confirmAction, declineAction])
        }
    }
    
    @objc private func cancelButtonDidPress() {
        
        self.startLoading()
        self.getAndReloadData(projectName: self.projectDetailsArr.first ?? Constants.NilCoalescingDefaults.string)
        self.stopLoading()
    }
    
    @IBAction private func addNewUserButtonDidPress(_ button: UIButton) {
        guard let newMemberVC = storyboard?.instantiateViewController(withIdentifier: String(describing:AddNewTeamMemberVC.self)) as? AddNewTeamMemberVC else { return }
        
        newMemberVC.callback = { [weak self] in
            guard let self = self,
                  let projectName = self.projectDetailsArr.first else { return }
            
            self.getAndReloadData(projectName: projectName)
        }
        newMemberVC.projectName = projectDetailsArr.first
        addChild(newMemberVC)
        newMemberVC.view.frame = view.frame
        view.addSubview(newMemberVC.view)
        newMemberVC.didMove(toParent: self)
    }
    
    private func userSpecificUI() {
        guard let role = UserDefaults.standard.object(forKey: Constants.UserDefaults.role) as? String else { return }
        
        if role == Roles.productOwner.rawValue {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.NavigationBarConstants.editTitle, style: .plain, target: self, action: #selector(editNavBarItemDidPress))
        }
    }
}

extension ProjectDescriptionVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.ProjectDescription.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.sectionHeading[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Constants.ProjectDescription.Sections.description.rawValue:
            return Constants.ProjectDescription.rowsInDescription
        case Constants.ProjectDescription.Sections.backlogs.rawValue:
            return Constants.ProjectDescription.rowsInBacklogs
        case Constants.ProjectDescription.Sections.team.rawValue:
            return Constants.ProjectDescription.rowsInTeam
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionItem = Constants.ProjectDescription.Sections(rawValue: indexPath.section)
        switch sectionItem ?? .description {
        case .description:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProjectDescriptionTVCell.self), for: indexPath) as? ProjectDescriptionTVCell else { return ProjectDescriptionTVCell() }
            
            cell.label.text = viewModel?.headings[indexPath.row]
            cell.textToDisplay.text = projectDetailsArr[indexPath.row]
            if viewModel?.editCondition == true{
                if indexPath.row != 0 {
                    cell.textToDisplay.isUserInteractionEnabled = true
                    cell.textToDisplay.isEditable = true
                }
            } else {
                cell.textToDisplay.isEditable = false
                cell.textToDisplay.isUserInteractionEnabled = false
            }
            return cell
        case .backlogs:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductBacklogTVCell.self), for: indexPath) as? ProductBacklogTVCell else { return ProjectDescriptionTVCell() }
            
            cell.backlogButton.setTitle(viewModel?.productBacklog[indexPath.row], for: .normal)
            cell.backlogButton.tag = indexPath.row
            cell.backlogButton.addTarget(self, action: #selector(backlogButtonDidPress(_:)), for: .touchUpInside)
            return cell
        case .team:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TeamMembersTVCell.self), for: indexPath) as? TeamMembersTVCell else { return TeamMembersTVCell() }
            
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func backlogButtonDidPress(_ button: UIButton) {
        
        let buttonTag = Constants.ProjectDescription.BacklogButton(rawValue: button.tag)
        switch buttonTag{
        case .backlog?:
            guard let backlogVC = storyboard?.instantiateViewController(withIdentifier: String(describing: StoriesDisplayVC.self)) as? StoriesDisplayVC else { return }
            
            backlogVC.projectName = projectDetailsArr[0]
            navigationController?.pushViewController(backlogVC, animated: true)
        case .sprint?:
            guard let backlogVC = storyboard?.instantiateViewController(withIdentifier: String(describing: SprintDisplayVC.self)) as? SprintDisplayVC else { return }
            
            backlogVC.viewModel = viewModel
            guard let projectDetails = projectDetails else { return }
            
            viewModel?.setCurrentProject(project: projectDetails)
            navigationController?.pushViewController(backlogVC, animated: true)
        default:
            print("")
        }
        
    }
}

extension ProjectDescriptionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return projectDetails?.teamMember.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TeamDisplayCVCell.self), for: indexPath) as? TeamDisplayCVCell else { return TeamDisplayCVCell() }

        cell.imageView.image = UIImage(named: "Teamwork-Theme")
        cell.imageView.layer.cornerRadius = cell.imageView.frame.width / 2
        cell.nameLabel.text = projectDetails?.teamMember[indexPath.row].name
        cell.roleLabel.text = projectDetails?.teamMember[indexPath.row].role
        cell.deleteTeamMeberButton.addTarget(self, action: #selector(removeUserButtonDidPress(_:)), for: .touchUpInside)
        cell.deleteTeamMeberButton.tag = indexPath.row
        cell.nameLabel.textColor = .black
        cell.roleLabel.textColor = .black
        cell.imageView?.alpha = 1.0
        if !(projectDetails?.teamMember[indexPath.row].role == Constants.RolesFullForm.productOwner) {
            if viewModel?.editCondition == false {
                cell.deleteTeamMeberButton.isHidden = true
            } else {
                cell.deleteTeamMeberButton.isHidden = false
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsPerRow = CGFloat(2.5)
        let availableWidth = collectionView.frame.size.width - CGFloat(Constants.CollectionViewCell.leftSpacing)
        let widthPerItem = availableWidth / cellsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("called")
    }

    @objc func removeUserButtonDidPress(_ button: UIButton) {
        if projectDetails?.teamMember[button.tag].role == Roles.productOwner.rawValue {
            showAlert(title: Constants.AlertMessages.poDeleteWarning, msg: Constants.AlertMessages.poDeleteMessage, actionTitle: Constants.AlertMessages.closeAction)
            return
        }
        let closeAlertAction = UIAlertAction(title: Constants.AlertMessages.checkAgain, style: .default, handler: nil)
        let confirmAlertAction = UIAlertAction(title: Constants.AlertMessages.confirmChanges, style: .destructive) { [weak self] (_) in
            guard let self = self else  { return }
            
            self.teamMembersToRemove.append(button.tag)
            guard let tvCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: Constants.ProjectDescription.Sections.team.rawValue)) as? TeamMembersTVCell,
                let cvCell = tvCell.collectionView.cellForItem(at: IndexPath(item: button.tag, section: 0)) as? TeamDisplayCVCell else { return }
            
            cvCell.nameLabel.textColor = .gray
            cvCell.roleLabel.textColor = .gray
            cvCell.imageView?.alpha = 0.2
        }
        showAlert(title: Constants.AlertMessages.confirmDelete, msg: Constants.AlertMessages.deleteMember, alertStyle: .alert, actions: [closeAlertAction, confirmAlertAction])
    }
}
