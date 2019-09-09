import UIKit

class NewProjectPopOverVC: BaseVC {
    
    @IBOutlet weak var actualView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var domainTextField: UITextField!
    @IBOutlet weak var descpTextField: UITextView!
    
    var viewModel = POViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        popOver()
    }
    
    @IBAction private func addProjectButtonDidPress(_ button: UIButton) {
        if titleTextField.text?.isEmpty ?? false {
            showAlert(title: Constants.AlertMessages.missingDataAlert, msg: "Project Title is Mandatory", actionTitle: Constants.AlertMessages.tryAgainAction)
        } else if domainTextField.text?.isEmpty ?? false {
            showAlert(title: Constants.AlertMessages.missingDataAlert, msg: "Project Domain is Mandatory", actionTitle: Constants.AlertMessages.tryAgainAction)
        } else if descpTextField.text?.isEmpty ?? false {
            showAlert(title: Constants.AlertMessages.missingDataAlert, msg: "Project Description is Mandatory", actionTitle: Constants.AlertMessages.tryAgainAction)
        } else {
            super.stopLoading()
            viewModel.addNewProject(title: titleTextField?.text ?? "", domain: domainTextField?.text ?? "", descp: descpTextField?.text ?? "") { [weak self] in
                self?.stopLoading()
                self?.showAlert(title: Constants.AlertMessages.successAlert, msg: "Project Created Successfully", actionTitle: Constants.AlertMessages.closeAction)
            }
            view.removeFromSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch: UITouch? = touches.first
        if touch?.view != actualView {
            view.removeFromSuperview()
        }
    }
    
    func popOver() {
        view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        view.alpha = 0.0
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.view.alpha = 1.0
            self?.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    override func startLoading() {
        super.startLoading()
    }
    
    override func stopLoading() {
        super.stopLoading()
    }
}
