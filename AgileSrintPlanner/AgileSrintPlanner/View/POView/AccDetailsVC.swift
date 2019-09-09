import UIKit

class AccDetailsVC: BaseVC {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var roleLabel: UILabel!
    
    var firebase = FirebaseManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = imageView.frame.width / 2
        startLoading()
        firebase.getUserDetails { [weak self] (name, email, role) in
            self?.nameLabel.text = name
            self?.emailLabel.text = email
            self?.roleLabel.text = self?.decideRole(role: role)
            self?.stopLoading()
        }
    }
    
    @IBAction private func signOutButtonDidPress(_ button: UIButton) {
        UserDefaults.standard.removeObject(forKey: Constants.UserDefaults.currentUser)
        UserDefaults.standard.removeObject(forKey: Constants.UserDefaults.role)
        UserDefaults.standard.synchronize()
        firebase.emailUserSignOut { [weak self] in
            guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController else { return }
            self?.present(viewController, animated: true, completion: nil)
        }
    }
    
    override func decideRole(role: String) -> String {
        return super.decideRole(role: role)
    }
    
    override func stopLoading() {
        super.stopLoading()
    }
}
