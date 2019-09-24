import UIKit
import Firebase
import Crashlytics
import GoogleSignIn
import FirebaseUI

class ViewController: BaseVC {
    
    @IBOutlet private weak var emailSignInButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var passwordextField: UITextField!
    @IBOutlet weak var bottomElementConstraint: NSLayoutConstraint!
    
    var fireBaseManager = FirebaseManager()
    
    deinit {
        print("MAina VC deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFieldDelegates(textField: nameTextField, returnType: .next)
        setupTextFieldDelegates(textField: passwordextField, returnType: .done)
        NotificationCenter.default.addObserver(self, selector: #selector(moveViewWhenKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveViewWhenKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction private func newUserButtonDidPress(_ button: UIButton) {
        NotificationCenter.default.removeObserver(self)
        guard let newUserVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: EmailSignInPopUpVC.self)) as? EmailSignInPopUpVC else { return }
        
        let navigationController = UINavigationController(rootViewController: newUserVC)
        present(navigationController, animated: true)
    }
    
    @IBAction private func emailLoginButtonDidPress(_ button: UIButton) {
        if nameTextField?.text?.isEmpty ?? true || passwordextField?.text?.isEmpty ?? true {
            showAlert(title: Constants.AlertMessages.failedLoginAlert, msg: Constants.EmailValidation.entiresMissing, actionTitle: Constants.AlertMessages.closeAction)
        } else if !isValidEmail(email: nameTextField.text ?? "") {
            showAlert(title: Constants.AlertMessages.failedLoginAlert, msg: Constants.EmailValidation.entriesWrongFormat, actionTitle: Constants.AlertMessages.closeAction)
        } else {
            startLoading()
            fireBaseManager.emailUserLogin(email: nameTextField?.text, password: passwordextField?.text) { [weak self] (user, error) in
                guard let weakSelf = self else { return }
                
                if let error = error {
                    let alertAction = UIAlertAction(title: Constants.AlertMessages.closeAction, style: .cancel, handler: nil)
                    DispatchQueue.main.async {
                        weakSelf.showAlert(title: Constants.AlertMessages.failedLoginAlert, msg: error.localizedDescription, alertStyle: .alert, actions: [alertAction])
                    }
                } else {
                    weakSelf.fireBaseManager.decideUserRole(user: Auth.auth().currentUser) { (viewController, role) in
                        guard let viewController = viewController else { return }
                
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
                            let navigationController = UINavigationController(rootViewController: viewController)
//                            weakSelf.dismiss(animated: true, completion: nil)
                            weakSelf.present(navigationController, animated: true)
                        }
                    }
                }
                weakSelf.stopLoading()
            }
        }
    }
    
    @IBAction private func passwordHideShowButtonDidPress(_ button: UIButton) {
        if passwordextField.isSecureTextEntry {
            passwordextField.isSecureTextEntry = false
        } else {
            passwordextField.isSecureTextEntry = true
        }
    }
    
    @objc func moveViewWhenKeyboard(notification: Notification) {
    }
    
    override func stopLoading() {
        super.stopLoading()
    }
    
    override func startLoading() {
        super.startLoading()
    }
}
