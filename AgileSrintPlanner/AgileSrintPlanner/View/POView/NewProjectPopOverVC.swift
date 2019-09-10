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
            showAlert(title: Constants.AlertMessages.missingDataAlert, msg: Constants.ProjectValidation.titleMissing, actionTitle: Constants.AlertMessages.tryAgainAction)
        } else if domainTextField.text?.isEmpty ?? false {
            showAlert(title: Constants.AlertMessages.missingDataAlert, msg: Constants.ProjectValidation.domainMissing, actionTitle: Constants.AlertMessages.tryAgainAction)
        } else if descpTextField.text?.isEmpty ?? false {
            showAlert(title: Constants.AlertMessages.missingDataAlert, msg: Constants.ProjectValidation.descriptionMissing, actionTitle: Constants.AlertMessages.tryAgainAction)
        } else {
            stopLoading()
            viewModel.addNewProject(title: titleTextField?.text ?? "", domain: domainTextField?.text ?? "", descp: descpTextField?.text ?? "") { [weak self] in
                guard let weakSelf = self else { return }

                DispatchQueue.main.async{
                    weakSelf.stopLoading()
                    weakSelf.showAlert(title: Constants.AlertMessages.successAlert, msg: Constants.ProjectValidation.success, actionTitle: Constants.AlertMessages.closeAction)
                    NotificationCenter.default.post(name: Notification.Name(Constants.NotificationCenterNames.newProjectAdded), object: nil)
                }
            }
            view.removeFromSuperview()
        }
    }
    
    func callBack(collectionView: inout UICollectionView) {
        
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
            guard let weakSelf = self else { return }
            
            weakSelf.view.alpha = 1.0
            weakSelf.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    override func startLoading() {
        super.startLoading()
    }
    
    override func stopLoading() {
        super.stopLoading()
    }
}
