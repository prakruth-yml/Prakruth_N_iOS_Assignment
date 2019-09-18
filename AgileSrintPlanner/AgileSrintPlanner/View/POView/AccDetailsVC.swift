import UIKit

class AccDetailsVC: BaseVC {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var roleLabel: UILabel!
    
    private var firebase = FirebaseManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.cornerRadius = imageView.frame.width / 2
        setUserDetails()
    }
    
    @IBAction private func signOutButtonDidPress(_ button: UIButton) {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier ?? "") 
        UserDefaults.standard.synchronize()
        
        firebase.emailUserSignOut { [weak self] in
            guard let viewController = self?.storyboard?.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController else { return }
            self?.present(viewController, animated: true, completion: nil)
        }
    }
    
    override func decideRole(role: String) -> String {
        return super.decideRole(role: role)
    }
    
    override func stopLoading() {
        super.stopLoading()
    }
    
    /// function to set user details to outlets
    private func setUserDetails() {
        nameLabel.text = UserDefaults.standard.object(forKey: Constants.UserDefaults.currentUserName) as? String
        emailLabel.text = UserDefaults.standard.object(forKey: Constants.UserDefaults.currentUserEmail) as? String
        roleLabel.text = decideRole(role: UserDefaults.standard.object(forKey: Constants.UserDefaults.role) as? String ?? "")
    }
}
