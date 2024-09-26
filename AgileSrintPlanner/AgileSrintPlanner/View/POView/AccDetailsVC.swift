import UIKit

class AccDetailsVC: BaseVC {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var roleLabel: UILabel!
    
    private var firebase = FirebaseManager()

    deinit {
        print("profile details vc deinit")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.cornerRadius = imageView.frame.width / 2
        setUserDetails()
    }
    
    @IBAction private func signOutButtonDidPress(_ button: UIButton) {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier ?? "") 
        UserDefaults.standard.synchronize()
        
        firebase.emailUserSignOut()
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController else { return }
        present(viewController, animated: true, completion: nil)
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
