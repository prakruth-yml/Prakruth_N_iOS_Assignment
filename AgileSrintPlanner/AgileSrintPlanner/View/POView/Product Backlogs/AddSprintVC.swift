//
//  AddSprintVC.swift
//  AgileSrintPlanner
//
//  Created by Prakruth Nagaraj on 17/09/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class AddSprintVC: BaseVC {

    @IBOutlet private weak var titleLabel: UITextField!
    @IBOutlet private weak var startdate: UIDatePicker!
    @IBOutlet private weak var endDate: UIDatePicker!
    @IBOutlet private weak var actualView: UIView!
    
    var viewModel: POViewModel?
    var callBack: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        popOver()
    }
    
    @IBAction private func closeButtonDidPress(_ button: UIButton) {
        view.removeFromSuperview()
    }
    
    @IBAction private func addSprintButtonDidPress(_ button: UIButton) {
        if titleLabel.text?.isEmpty ?? true {
            showAlert(title: Constants.AlertMessages.missingDataAlert, msg: "Sprint Title is Manadatory", actionTitle: Constants.AlertMessages.tryAgainAction)
        } else {
            startLoading()
            viewModel?.setCurrentSprint(title: titleLabel.text ?? "", startDate: viewModel?.sprintStartDate ?? "", endDate: viewModel?.sprintEndDate ?? "")
            viewModel?.addSprint(projectName: viewModel?.currentProject?.data.title ?? "", sprint: viewModel?.currentSprint) { [weak self] (error) in
                guard let self = self else { return }
                
                if let error = error {
                    self.stopLoading()
                    self.showAlert(title: Constants.AlertMessages.errorAlert, msg: error.localizedDescription, actionTitle: Constants.AlertMessages.closeAction)
                } else {
                    self.stopLoading()
                    self.view.removeFromSuperview()
                    self.showAlert(title: Constants.AlertMessages.successAlert, msg: Constants.AlertMessages.sprintSuccess, actionTitle: Constants.AlertMessages.closeAction)
                    self.callBack?()
                }
            }
        }
    }
    
    @IBAction private func startDatePicked(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.dateStyle = DateFormatter.Style.short
        print(dateFormatter.string(from: startdate.date))
        viewModel?.setSprintStartDate(date: dateFormatter.string(from: startdate.date))
    }
    
    @IBAction private func endDatePicked(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        print(dateFormatter.string(from: endDate.date))
        viewModel?.setSprintEndDate(date: dateFormatter.string(from: endDate.date))
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
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//
//        let touch: UITouch? = touches.first
//        if touch?.view != actualView {
//            view.removeFromSuperview()
//        }
//    }
}
