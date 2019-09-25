import UIKit
import Firebase
import FirebaseUI

class EmailSignInPopUpVC: BaseVC {

    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailIdTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordTF: UITextField!
    @IBOutlet private weak var regButtonBottomConstraint: NSLayoutConstraint!
    
    var firebaseManager = FirebaseManager()
    var viewModel = BaseVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFieldDelegatesInLocal()
        signUpButton.imageView?.contentMode = .scaleAspectFit
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-back-50"), style: .plain, target: self, action: #selector(backButtonDidPress))
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = UIColor(red: 0.0, green: 145/255, blue: 147/255, alpha: 1.0)
        NotificationCenter.default.addObserver(self, selector: #selector(moveViewWhenKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveViewWhenKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
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
                        weakSelf.firebaseManager.emailUserLogin(email: weakSelf.emailIdTextField.text ?? "", password: weakSelf.passwordTextField.text ?? "") { (user, error) in
                            
                            if let error = error {
                                let alertAction = UIAlertAction(title: Constants.AlertMessages.closeAction, style: .cancel, handler: nil)
                                DispatchQueue.main.async {
                                    weakSelf.showAlert(title: Constants.AlertMessages.failedLoginAlert, msg: error.localizedDescription, alertStyle: .alert, actions: [alertAction])
                                }
                            } else {
                                weakSelf.firebaseManager.decideUserRole(user: Auth.auth().currentUser) { (viewController, role) in
                                    guard let viewController = viewController else {
                                        self?.showAlert(title: Constants.AlertMessages.errorAlert, msg: "User Not Assign any project", actionTitle: Constants.AlertMessages.closeAction)
                                        self?.firebaseManager.emailUserSignOut()
                                        self?.stopLoading()
                                        return
                                    }
                                    
                                    let currentUser = Auth.auth().currentUser
                                    UserDefaults.standard.set(role, forKey: Constants.UserDefaults.role)
                                    UserDefaults.standard.set(currentUser?.displayName, forKey: Constants.UserDefaults.currentUserName)
                                    UserDefaults.standard.set(currentUser?.uid, forKey: Constants.UserDefaults.currentUserId)
                                    UserDefaults.standard.set(currentUser?.email, forKey: Constants.UserDefaults.currentUserEmail)
                                    currentUser?.getIDTokenResult(forcingRefresh: true, completion: { (token, _) in
                                        guard let token = token else { return }
                                        
                                        UserDefaults.standard.set(token.claims, forKey: Constants.UserDefaults.currentUser)
                                    })
                                    DispatchQueue.main.async {
                                        weakSelf.navigationController?.pushViewController(viewController, animated: true)
                                    }
                                }
                            }
                            weakSelf.stopLoading()
                        }
                    }
                }
            }
        }
    }
    
    @objc func moveViewWhenKeyboard(notification: Notification) {

    }
    
    @objc func backButtonDidPress() {
        dismiss(animated: true, completion: nil)
    }
    
//    override func setupTextFieldDelegates(textField: UITextField, returnType: UIReturnKeyType) {
//        super.setupTextFieldDelegates(textField: textField, returnType: returnType)
//
//        if returnType == .next {
//            textField.resignFirstResponder()
//        }
//    }
    
    func setupTextFieldDelegatesInLocal() {
        setupTextFieldDelegates(textField: nameTextField, returnType: .next)
        setupTextFieldDelegates(textField: emailIdTextField, returnType: .next)
        setupTextFieldDelegates(textField: passwordTextField, returnType: .next)
        setupTextFieldDelegates(textField: confirmPasswordTF, returnType: .done)
    }
}
