import UIKit

class AddNewTeamMemberVC: BaseVC {
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var actualView: UIView!
    
    var viewModel = POViewModel()
    var projectName: String?
    var callback: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        popOver()
    }
    
    @IBAction private func addTeamMemberButtonDidPress(_ button: UIButton) {
        if nameTextField.text?.isEmpty ?? Constants.NilCoalescingDefaults.bool || emailTextField.text?.isEmpty ?? Constants.NilCoalescingDefaults.bool {
            showAlert(title: Constants.AlertMessages.missingDataAlert, msg: "Email or name missing", actionTitle: Constants.AlertMessages.tryAgainAction)
        } else if !isValidEmail(email: emailTextField.text ?? Constants.NilCoalescingDefaults.string) {
            showAlert(title: Constants.AlertMessages.errorAlert, msg: Constants.EmailValidation.entriesWrongFormat, actionTitle: Constants.AlertMessages.tryAgainAction)
        } else {
            guard let nameTextFieldText = nameTextField.text else { return }
            guard let emailTextFieldText = emailTextField.text else { return }
            startLoading()
            let teamMember = ProfileDetails(name: nameTextFieldText, role: "dev", email: emailTextFieldText)
            
            viewModel.addNewTeamMember(projectName: projectName ?? Constants.NilCoalescingDefaults.string, teamMember: teamMember) { [weak self] (error) in
                guard let weakSelf = self, error == nil else {
                    self?.showAlert(title: Constants.AlertMessages.errorAlert, msg: error?.localizedDescription ?? "", actionTitle: Constants.AlertMessages.closeAction)
                    return
                }
    
                weakSelf.reloadAfterAddingUser()
            }
        }
    }
    
    @IBAction private func closeButtonDidPress(_ button: UIButton) {
        view.removeFromSuperview()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let touch: UITouch? = touches.first
        if touch?.view != actualView {
            view.removeFromSuperview()
        }
    }
    
    /// Function to animate the popover effect
    func popOver() {
        view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        view.alpha = 0.0
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let weakSelf = self else { return }
            
            weakSelf.view.alpha = 1.0
            weakSelf.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func reloadAfterAddingUser() {
        stopLoading()
        view.removeFromSuperview()
        showAlert(title: Constants.AlertMessages.successAlert, msg: "Team Member added Successfully", actionTitle: Constants.AlertMessages.closeAction)
        callback?()
    }
}

extension AddNewTeamMemberVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return projectRoles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.projectRolePicked = projectRoles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return projectRoles[row]
    }
}
