import UIKit

class ProjectDescriptionVC: BaseVC {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var newUserButton: UIButton!
    
    var projectDetails: ProjectDetails?
    var projectDetailsArr: [String] = []
    var editCondition = false
    
    var viewModel = POViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        projectDetailsArr = [projectDetails?.data.title, projectDetails?.data.domain, projectDetails?.data.descp] as? [String] ?? [""]
        print(projectDetails?.teamMember)
        navigationItem.title = projectDetailsArr.first
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.NavigationBarConstants.editTitle, style: .plain, target: self, action: #selector(editNavBarItemDidPress))
        tableView.tableFooterView = UIView()
        newUserButton.layer.cornerRadius = newUserButton.imageView?.frame.width ?? 1.0 / 2
    }
    
    @objc func editNavBarItemDidPress() {
        if !editCondition {
            editCondition = true
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.NavigationBarConstants.doneTitle, style: .plain, target: self, action: #selector(editNavBarItemDidPress))
            tableView.reloadData()
        } else {
            editCondition = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.NavigationBarConstants.editTitle, style: .plain, target: self, action: #selector(editNavBarItemDidPress))
            tableView.reloadData()
        }
    }
    
    @IBAction private func addNewUserButtonDidPress(_ button: UIButton) {
        
    }
}

extension ProjectDescriptionVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.ProjectDescription.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionHeading[section]
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
            if editCondition {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProjectDescriptionTVCell.self), for: indexPath) as? ProjectDescriptionTVCell else { return ProjectDescriptionTVCell() }
                
                cell.label.text = viewModel.headings[indexPath.row]
                cell.textToDisplay.text = projectDetailsArr[indexPath.row]
                cell.textToDisplay.isUserInteractionEnabled = true
                cell.textToDisplay.isEditable = true
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProjectDescriptionTVCell.self), for: indexPath) as? ProjectDescriptionTVCell else { return ProjectDescriptionTVCell() }
                
                cell.label.text = viewModel.headings[indexPath.row]
                cell.textToDisplay.text = projectDetailsArr[indexPath.row]
                cell.textToDisplay.isEditable = false
                cell.backgroundColor = UIColor.yellow
                return cell
            }
        case .backlogs:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductBacklogTVCell.self), for: indexPath) as? ProductBacklogTVCell else { return ProjectDescriptionTVCell() }
            
            return cell
        case .team:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TeamMembersTVCell.self), for: indexPath) as? TeamMembersTVCell else { return TeamMembersTVCell() }
            
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            return cell
        default:
            return ProductBacklogTVCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case Constants.ProjectDescription.Sections.team.rawValue:
            return 0.4609 * view.frame.height
        default:
            return UITableView.automaticDimension
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsPerRow = CGFloat(2)
        let availableWidth = collectionView.frame.size.width - CGFloat(Constants.CollectionViewCell.leftSpacing)
        let widthPerItem = availableWidth / cellsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}
