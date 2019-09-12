import UIKit

class AddNewTeamMemberVC: BaseVC {
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var actualView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        popOver()
    }
    
    @IBAction private func addTeamMemberButtonDidPress(_ button: UIButton) {
        view.removeFromSuperview()
    }
    
    @IBAction private func closeButtonDidPress(_ button: UIButton) {
        view.removeFromSuperview()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let touch: UITouch? = touches.first
        if touch?.view != actualView {
            view.removeFromSuperview()
        }
    }
    
    /// Function to animate the popover effect
    func popOver() {
        view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        view.alpha = 0.0
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let weakSelf = self else { return }
            
            weakSelf.view.alpha = 1.0
            weakSelf.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
}
