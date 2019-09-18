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
        getUserDetailsFromFirbase()
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
    
    private func getUserDetailsFromFirbase() {
        startLoading()
        nameLabel.text = UserDefaults.standard.object(forKey: Constants.UserDefaults.currentUserName) as? String
        emailLabel.text = UserDefaults.standard.object(forKey: Constants.UserDefaults.currentUserEmail) as? String
        roleLabel.text = decideRole(role: UserDefaults.standard.object(forKey: Constants.UserDefaults.role) as? String ?? "")
        stopLoading()
//        firebase.getUserDetails { [weak self] profile in
//            guard let self = self else { return }
//
//            self.nameLabel.text = UserDefaults.standard.object(forKey: Constants.UserDefaults.currentUserName) as? String
//            self.emailLabel.text = UserDefaults.standard.object(forKey: Constants.UserDefaults.currentUserEmail) as? String
//            self.roleLabel.text = self.decideRole(role: UserDefaults.standard.object(forKey: Constants.UserDefaults.role) as? String ?? "")
//            self.stopLoading()
//        }
    }
}
