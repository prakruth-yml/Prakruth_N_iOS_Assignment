import UIKit
import Firebase
import Crashlytics

class BaseVC: UIViewController {
    
    let activityIndicator = UIActivityIndicatorView()
    var activityView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(moveViewWhenKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveViewWhenKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
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
        
        activityView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width/2, height: view.frame.height/4))
        let blurVC = UIVisualEffectView(frame: activityView.frame)
        blurVC.effect = UIBlurEffect(style: .prominent)
        activityView.center = view.center
        activityView.addSubview(blurVC)
        activityView.addSubview(activityIndicator)
        blurVC.clipsToBounds = true
        blurVC.layer.cornerRadius = 15
        activityIndicator.center = CGPoint(x: activityView.frame.width/2, y: activityView.frame.height/2)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.color = .darkGray
        view.addSubview(activityView)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    /// Function to stop activity indicator
    func stopLoading() {
        activityIndicator.stopAnimating()
        activityView.removeFromSuperview()
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
    
    @objc func moveViewWhenKeyboard(notification: Notification) {
        guard let notificationInfo = notification.userInfo else { return }
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            guard let keyBoardFrame = (notificationInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
            
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyBoardFrame.height
            }
        } else if notification.name == UIResponder.keyboardWillHideNotification && view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
}

extension BaseVC: UITextFieldDelegate {
    
    /// setup textfield delegates
    func setupTextFieldDelegates(textField: UITextField, returnType: UIReturnKeyType) {
        textField.delegate = self
        textField.returnKeyType = returnType
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension UIColor {
    
    static func randomClr() -> UIColor {
        return UIColor(red: CGFloat.random(in: 0.5...1), green: CGFloat.random(in: 0.5...1), blue: CGFloat.random(in: 0.5...1), alpha: 1.0)
    }
}
