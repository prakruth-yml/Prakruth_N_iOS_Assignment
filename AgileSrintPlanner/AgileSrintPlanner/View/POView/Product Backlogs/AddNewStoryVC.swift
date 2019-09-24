import UIKit

class AddNewStoryVC: BaseVC {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var titleTextField: UITextField!

    var viewModel: ProductBacklogsViewModel?
    var callBack: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func addStoryButtonDidPress(_ button: UIButton) {
        addStory()
    }
    
    @IBAction private func addAndClearStoryButtonDidPress(_ button: UIButton) {
        
    }
    
    /// Function to make api call to add story to database
    private func addStory() {
        viewModel?.storyDetailsToAdd.removeAll()
        viewModel?.storyDetailsToAdd.append(titleTextField.text ?? "")
        for row in 0..<Constants.StoryDisplayTableView.numberOfRows {
            guard let cellItem = Constants.StoryDisplayTableView.CellTag(rawValue: row) else { return }
            switch cellItem {
            case .issueType:
                viewModel?.storyDetailsToAdd.append(viewModel?.newTaskPicked ?? "")
            case .platform:
                viewModel?.storyDetailsToAdd.append(viewModel?.newPlatformPicked ?? "")
            case .summary, .descp:
                guard let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? AddNewStoryTextViewTVCell else { return }
                
                viewModel?.storyDetailsToAdd.append(cell.descpTextView.text ?? "")
            }
        }
        viewModel?.storyDetailsToAdd.append(Constants.FirebaseConstants.ProjectTable.Stories.status)
        startLoading()
        viewModel?.addStoryToFirebase(projectName: viewModel?.currentProject?.data.title ?? "", story: viewModel?.storyDetailsToAdd) { [weak self] (error) in
            guard let self = self else { return }
            if let error = error {
                self.stopLoading()
                self.showAlert(title: Constants.AlertMessages.errorAlert, msg: error.localizedDescription, actionTitle: Constants.AlertMessages.closeAction)
            } else {
                self.stopLoading()
                let closeAction = UIAlertAction(title: Constants.AlertMessages.closeAction, style: .cancel, handler: { [weak self] (_) in
                    self?.navigationController?.popViewController(animated: true)
                    self?.callBack?()
                })
                self.showAlert(title: Constants.AlertMessages.closeAction, msg: Constants.AlertMessages.storySuccess, alertStyle: .alert, actions: [closeAction])
            }
        }
    }
}

extension AddNewStoryVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.StoryDisplayTableView.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellItem = Constants.StoryDisplayTableView.CellTag(rawValue: indexPath.row)
        switch cellItem {
        case .issueType?:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AddNewStoryDataPickerTVCell.self), for: indexPath) as? AddNewStoryDataPickerTVCell else { return AddNewStoryDataPickerTVCell() }
            
            cell.fieldDataPicker.tag = Constants.StoryDisplayTableView.CellTag.issueType.rawValue
            cell.fieldDataPicker.dataSource = self
            cell.fieldDataPicker.delegate = self
            cell.setupCell(title: "Issue Type")
            return cell
        case .summary?:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AddNewStoryTextViewTVCell.self), for: indexPath) as? AddNewStoryTextViewTVCell else { return AddNewStoryTextViewTVCell() }
            
            cell.setupCell(title: "Summary")
            return cell
        case .descp?:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AddNewStoryTextViewTVCell.self), for: indexPath) as? AddNewStoryTextViewTVCell else { return AddNewStoryTextViewTVCell() }
            
            cell.setupCell(title: "Description")
            return cell
        case .platform?:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AddNewStoryDataPickerTVCell.self), for: indexPath) as? AddNewStoryDataPickerTVCell else { return AddNewStoryDataPickerTVCell() }
            
            cell.setupCell(title: "Platform")
            cell.fieldDataPicker.dataSource = self
            cell.fieldDataPicker.delegate = self
            cell.fieldDataPicker.tag = Constants.StoryDisplayTableView.CellTag.platform.rawValue
            return cell
        default:
            return AddNewStoryTextViewTVCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        tableView.resignFirstResponder()
    }
}

extension AddNewStoryVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch  pickerView.tag {
        case Constants.StoryDisplayTableView.CellTag.issueType.rawValue:
            return viewModel?.pickerIssueTyeps.count ?? 1
        case Constants.StoryDisplayTableView.CellTag.platform.rawValue:
            return viewModel?.pickerPlatforms.count ?? 1
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch  pickerView.tag {
        case Constants.StoryDisplayTableView.CellTag.issueType.rawValue:
            viewModel?.newTaskPicked = viewModel?.pickerIssueTyeps[row] ?? ""
        case Constants.StoryDisplayTableView.CellTag.platform.rawValue:
            viewModel?.newPlatformPicked = viewModel?.pickerPlatforms[row] ?? ""
        default:
            print("")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch  pickerView.tag {
        case Constants.StoryDisplayTableView.CellTag.issueType.rawValue:
            return viewModel?.pickerIssueTyeps[row]
        case Constants.StoryDisplayTableView.CellTag.platform.rawValue:
            return viewModel?.pickerPlatforms[row]
        default:
            return ""
        }
    }
}
