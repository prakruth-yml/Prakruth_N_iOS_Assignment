import UIKit
import Firebase
import FirebaseDatabase
import FirebaseUI

class ProductOwnerMainVC: BaseVC {
    
    @IBOutlet private weak var emptyLabel: UILabel!
    @IBOutlet weak var listGridButton: UIImageView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var navBarItem: UINavigationItem!
    
    private var viewModel = POViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon-user-acc"), style: .plain, target: self, action: #selector(userDisplayButtonDidPress))
        navBarItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-menu-50"), style: .plain, target: self, action: #selector(listImageDidPress))
        getAndReloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    private func getAndReloadData() {
        startLoading()
        viewModel.getProjectDetailsFromFM { [weak self] in
            guard let weakSelf = self else { return }
            
            weakSelf.collectionView.reloadData()
            weakSelf.stopLoading()
        }
    }
    
    @IBAction private func addButtonDidPress(_ button: UIButton) {
        guard let newProjectVC = storyboard?.instantiateViewController(withIdentifier: String(describing: NewProjectPopOverVC.self)) as? NewProjectPopOverVC else { return }
        
        newProjectVC.callback = { [weak self] in
            guard let self = self else { return }
            
            self.getAndReloadData()
        }
        addChild(newProjectVC)
        newProjectVC.view.frame = view.frame
        view.addSubview(newProjectVC.view)
        newProjectVC.didMove(toParent: self)
    }
    
    @objc private func userDisplayButtonDidPress(_ button: UIButton) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: String(describing: AccDetailsVC.self)) as? AccDetailsVC else { return }
        
        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc private func listImageDidPress(_ sender: UITapGestureRecognizer) {
        
    }
}

extension ProductOwnerMainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.projectDetails?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: POProductBacklogCVCell.self), for: indexPath) as? POProductBacklogCVCell
        cell?.titleOfProject.text = viewModel.projectDetails?[indexPath.row].data.title
        cell?.domainOfProject.text = viewModel.projectDetails?[indexPath.row].data.domain
        cell?.descriptionOfProject.text = viewModel.projectDetails?[indexPath.row].data.descp
        cell?.backgroundColor = UIColor.randomClr()
        cell?.layer.cornerRadius = 7.0
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsPerRow = CGFloat(1)
        let availableWidth = collectionView.frame.size.width - CGFloat(Constants.CollectionViewCell.leftSpacing)
        let widthPerItem = availableWidth / cellsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: String(describing: ProjectDescriptionVC.self)) as? ProjectDescriptionVC else { return }
        
        viewController.projectDetails = viewModel.projectDetails?[indexPath.row]
//        viewController.teamMember = viewModel.
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension UIColor {
    
    static func randomClr() -> UIColor {
        return UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1.0)
    }
}
