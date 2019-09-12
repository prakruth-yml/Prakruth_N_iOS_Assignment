import UIKit

class NewProjectPopOverVC: BaseVC {
    
    @IBOutlet private weak var actualView: UIView!
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var domainTextField: UITextField!
    @IBOutlet private weak var descpTextField: UITextView!
    @IBOutlet private weak var iosButton: UIButton!
    @IBOutlet private weak var androidButton: UIButton!
    @IBOutlet private weak var backEndButton: UIButton!
    @IBOutlet private weak var frontEndButton: UIButton!
    
    var callback: (() -> Void)?
    var viewModel = POViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        popOver()
    }
    
    @IBAction private func iosButtonDidPress(_ button: UIButton) {
        setTextField(button: iosButton, stringToAppend: Constants.YMLDomains.ios)
    }
    
    @IBAction private func androidButtonDidPress(_ button: UIButton) {
        setTextField(button: androidButton, stringToAppend: Constants.YMLDomains.android)
    }
    
    @IBAction private func backEndButtonDidPress(_ button: UIButton) {
        setTextField(button: backEndButton, stringToAppend: Constants.YMLDomains.bk)
    }
    
    @IBAction private func frontEndButtonDidPress(_ button: UIButton) {
        setTextField(button: frontEndButton, stringToAppend: Constants.YMLDomains.front)
    }
    
    @IBAction private func addProjectButtonDidPress(_ button: UIButton) {
        if titleTextField.text?.isEmpty ?? false {
            showAlert(title: Constants.AlertMessages.missingDataAlert, msg: Constants.ProjectValidation.titleMissing, actionTitle: Constants.AlertMessages.tryAgainAction)
        } else if domainTextField.text?.isEmpty ?? false {
            showAlert(title: Constants.AlertMessages.missingDataAlert, msg: Constants.ProjectValidation.domainMissing, actionTitle: Constants.AlertMessages.tryAgainAction)
        } else if descpTextField.text?.isEmpty ?? false {
            showAlert(title: Constants.AlertMessages.missingDataAlert, msg: Constants.ProjectValidation.descriptionMissing, actionTitle: Constants.AlertMessages.tryAgainAction)
        } else {
            stopLoading()
            guard let poName = UserDefaults.standard.object(forKey: Constants.UserDefaults.currentUserName) as? String else { return }
            
            viewModel.addNewProject(title: titleTextField?.text ?? "", domain: domainTextField?.text ?? "", descp: descpTextField?.text ?? "", poName: poName) { [weak self] in
                guard let weakSelf = self else { return }

                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    weakSelf.stopLoading()
                    weakSelf.showAlert(title: Constants.AlertMessages.successAlert, msg: Constants.ProjectValidation.success, actionTitle: Constants.AlertMessages.closeAction)
                    self.callback?()
                }
            }
            view.removeFromSuperview()
        }
    }
    
    @IBAction private func closeButtonDidPress(_ button: UIButton) {
        view.removeFromSuperview()
    }
    
    /// Sets the domain textfield and disables the buttom
    ///
    /// - Parameters:
    ///   - stringToAppend: string to append to textfield
    ///   - button: button to disable
    private func setTextField(button: UIButton, stringToAppend: String) {
        guard let textFieldText = domainTextField.text else { return }
        
        domainTextField.text = textFieldText + ", " + stringToAppend
        button.isUserInteractionEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let touch: UITouch? = touches.first
        if touch?.view != actualView {
            view.removeFromSuperview()
        }
    }
    
    func popOver() {
        view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        view.alpha = 0.0
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let weakSelf = self else { return }
            
            weakSelf.view.alpha = 1.0
            weakSelf.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    override func startLoading() {
        super.startLoading()
    }
    
    override func stopLoading() {
        super.stopLoading()
    }
}
