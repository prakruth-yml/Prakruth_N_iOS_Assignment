import UIKit

class NewProjectPopOverVC: BaseVC {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var domainTextField: UITextField!
    @IBOutlet weak var descpTextField: UITextView!
    
    var viewModel = POViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        popOver()
    }
    
    @IBAction private func addProjectButtonDidPress(_ button: UIButton) {
        viewModel.addNewProject(title: titleTextField?.text ?? "", domain: domainTextField?.text ?? "", descp: descpTextField?.text ?? "") {
            super.showAlert(title: "Success", msg: "Project Created Successfully", actionTitle: "Close")
        }
        view.removeFromSuperview()
        
    }
    
    func popOver() {
        view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        view.alpha = 0.0
        UIView.animate(withDuration: 0.5, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
}
