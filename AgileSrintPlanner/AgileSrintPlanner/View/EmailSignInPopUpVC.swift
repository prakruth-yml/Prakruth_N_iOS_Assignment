import UIKit
import Firebase
import FirebaseUI

class EmailSignInPopUpVC: BaseVC {

    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailIdTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordTF: UITextField!
    
    var firebaseManager = FirebaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFieldDelegates()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        signUpButton.imageView?.contentMode = .scaleAspectFit
        popOver()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    /// function to describe animation for popover
    private func popOver() {
        view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    @IBAction private func closeButtonDidPress(_ button: UIButton) {
        view.removeFromSuperview()
    }
    
    @IBAction private func signInButtonDidPress(_ button: UIButton) {
        if emailIdTextField.text?.isEmpty ?? true || passwordTextField.text?.isEmpty ?? true || nameTextField.text?.isEmpty ?? true {
            showAlert(title: Constants.AlertMessages.errorAlert, msg: Constants.EmailValidation.entiresMissing, actionTitle: Constants.AlertMessages.closeAction)
        } else if !isValidEmail(email: emailIdTextField.text ?? "") {
            showAlert(title: Constants.AlertMessages.errorAlert, msg: Constants.EmailValidation.entriesWrongFormat, actionTitle: Constants.AlertMessages.closeAction)
        } else if passwordTextField.text != confirmPasswordTF.text {
            showAlert(title: Constants.AlertMessages.failedLoginAlert, msg: Constants.EmailValidation.passwordsMismatch, actionTitle: Constants.AlertMessages.closeAction)
        } else {
            startLoading()
            firebaseManager.emailLoginUserCreate(name: nameTextField.text ?? "name", email: emailIdTextField.text ?? "email", password: passwordTextField.text ?? "password") { [weak self] (error) in
                guard let weakSelf = self else { return }
                
                if let error = error {
                    DispatchQueue.main.async {
                        let alertAction = UIAlertAction(title: Constants.AlertMessages.closeAction, style: .cancel, handler: nil)
                        weakSelf.showAlert(title: Constants.AlertMessages.userCreationFailedAlert, msg: error.localizedDescription, alertStyle: .alert, actions: [alertAction])
                        weakSelf.stopLoading()
                    }
                } else {
                    DispatchQueue.main.async {
                        weakSelf.view.removeFromSuperview()
                        weakSelf.stopLoading()
                        weakSelf.showAlert(title: Constants.AlertMessages.closeAction, msg: "Account has been created successfully. Please login with the same", actionTitle: Constants.AlertMessages.closeAction)
                    }
                }
            }
        }
    }
}

extension EmailSignInPopUpVC: UITextFieldDelegate {
    
    /// function to setup textfield delegates
    func setupTextFieldDelegates() {
        emailIdTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTF.delegate = self
        emailIdTextField.returnKeyType = .next
        passwordTextField.returnKeyType = .next
        confirmPasswordTF.returnKeyType = .done
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
