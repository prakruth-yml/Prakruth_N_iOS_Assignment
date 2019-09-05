import UIKit
import Firebase
import Crashlytics
import GoogleSignIn
import FirebaseUI

class ViewController: BaseVC, GIDSignInDelegate, GIDSignInUIDelegate {
    
    @IBOutlet private weak var emailSignInButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var passwordextField: UITextField!
    
    var fireBaseManager = FirebaseManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
        emailSignInButton.imageView?.contentMode = .scaleAspectFit
    }
    
    @IBAction private func newUserButtonDidPress(_ button: UIButton) {
        guard let popVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: EmailSignInPopUpVC.self)) as? EmailSignInPopUpVC else { fatalError() }
        
        self.addChild(popVC)
        popVC.view.frame = view.frame
        view.addSubview(popVC.view)
        popVC.didMove(toParent: self)
    }

    @IBAction private func emailLoginButtonDidPress(_ button: UIButton) {
        if nameTextField?.text?.isEmpty ?? true || passwordextField?.text?.isEmpty ?? true {
            showAlert(title: "Login Failed", msg: "Email or Password Missing", actionTitle: "Close")
        } else if !isValidEmail(email: nameTextField.text ?? "") {
            showAlert(title: "Login Failed", msg: "Email Id Wrongly Formated", actionTitle: "Close")
        } else {
            fireBaseManager.emailUserLogin(email: nameTextField?.text, password: passwordextField?.text) { (user, error) in
                if error != "nil" {
                    self.showAlert(title: "Login Failed", msg: error, actionTitle: "Try Again")
                } else {
                    self.fireBaseManager.decideUserRole(user: Auth.auth().currentUser) { (viewController) in
                        guard let viewController = viewController else { return }
                        self.present(viewController, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @IBAction private func passwordHideShowButtonDidPress(_ button: UIButton) {
        if passwordextField.isHidden {
            passwordextField.isHidden = false
        }
        else{
            passwordextField.isHidden = true
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error)
            return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                return
            }
            
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
    }
}
