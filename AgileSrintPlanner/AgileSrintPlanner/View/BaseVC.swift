import UIKit
import Firebase
import Crashlytics

class BaseVC: UIViewController {
    
    let activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// Base function to show alert view controller
    ///
    /// - Parameters:
    ///   - title: Title of the alert
    ///   - msg: Alert message
    ///   - actionTitle: Action title
    func showAlert(title: String, msg: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: actionTitle, style: .cancel, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    /// Base function to show alert view controller with custom alert actions
    ///
    /// - Parameters:
    ///   - title: Title of the alert
    ///   - msg: Alert message
    ///   - alertStyle: Alert style
    ///   - actions: Custom actions
    func showAlert(title: String, msg: String, alertStyle: UIAlertController.Style, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
    
    /// Function to check if email is of valid format
    ///
    /// - Parameter email: Email to check
    /// - Returns: True if email is of valid format
    func isValidEmail(email: String) -> Bool {
        let pattern = Constants.EmailValidation.emailRegex
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return regex?.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.count)) != nil
    }
    
    /// Function to start activity indicator
    func startLoading() {
        
        let blurVC = UIVisualEffectView()
        blurVC.frame = activityIndicator.frame
        blurVC.effect = UIBlurEffect(style: .regular)
        activityIndicator.addSubview(blurVC)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.color = UIColor.blue
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    /// Function to stop activity indicator
    func stopLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    /// Function to produce the full form of a given role
    ///
    /// - Parameter role: Role to obtain full form
    /// - Returns: The full form of the role
    func decideRole(role: String) -> String {
        switch(role) {
        case Roles.productOwner.rawValue:
            return Constants.RolesFullForm.productOwner
        case Roles.projectManager.rawValue:
            return Constants.RolesFullForm.projectManager
        case Roles.developer.rawValue:
            return Constants.RolesFullForm.dev
        default:
            return ""
        }
    }
}
