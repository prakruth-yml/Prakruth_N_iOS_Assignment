import UIKit
import Firebase
import FirebaseDatabase
import FirebaseUI

class ProductOwnerMainVC: BaseVC {
    
    @IBOutlet weak var hiddenText: UILabel!
    @IBOutlet weak var accDetails: UIImageView!
    @IBOutlet weak var listGridButton: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    
    let firebaseManager = FirebaseManager()
    var viewModel = POViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userTapGesture = UITapGestureRecognizer(target: self, action: #selector(userImageDidPress(_:)))
        let listTapGesture = UITapGestureRecognizer(target: self, action: #selector(listImageDidPress(_:)))
        accDetails.addGestureRecognizer(userTapGesture)
        listGridButton.addGestureRecognizer(listTapGesture)
        setupDetailsView()
        firebaseManager.getProjectDetails()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch: UITouch? = touches.first
        if touch?.view != detailsView {
            detailsView.isHidden = true
        }
    }
    
    @IBAction private func signOutButtonDidPress(_ button: UIButton) {
        viewModel.firebase.emailUserSignOut() {
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController else { fatalError() }
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction private func addButtonDidPress(_ button: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: NewProjectPopOverVC.self)) as? NewProjectPopOverVC else { fatalError() }
        addChild(vc)
        vc.view.frame = view.frame
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    @objc func userImageDidPress(_ sender: UITapGestureRecognizer) {
        
        detailsView.isHidden = false
    }
    
    @objc func listImageDidPress(_ sender: UITapGestureRecognizer) {
        
    }
    
    func setupDetailsView() {
        
        firebaseManager.getUserDetails() { (email, role) in
            DispatchQueue.main.async {
                self.emailLabel.text = email
                self.roleLabel.text = role
            }
        }
    }
}

extension ProductOwnerMainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: POProductBacklogCVCell.self), for: indexPath) as? POProductBacklogCVCell
        cell?.titleOfProject.text = "hello"
        cell?.domainOfProject.text = "IOS"
        cell?.descriptionOfProject.text = "hbcdkbcsaksdb"
        return cell ?? UICollectionViewCell()
    }
}
