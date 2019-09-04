import UIKit
import Firebase
import Crashlytics
import GoogleSignIn
import FirebaseUI

class ViewController: BaseVC, GIDSignInDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var emailSignInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordextField: UITextField!
    
    var fireBaseManager = FirebaseManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
        emailSignInButton.imageView?.contentMode = .scaleAspectFit
    }
    
    @IBAction func newUserButtonDidPress(_ button: UIButton) {
        guard let popVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: EmailSignInPopUpVC.self)) as? EmailSignInPopUpVC else { fatalError() }
        self.addChild(popVC)
        popVC.view.frame = view.frame
        view.addSubview(popVC.view)
        popVC.didMove(toParent: self)
    }

    @IBAction func emailLoginButtonDidPress(_ button: UIButton) {
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
