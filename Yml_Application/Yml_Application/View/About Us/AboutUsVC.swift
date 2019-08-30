import UIKit
import AVFoundation

class AboutUsVC: BaseVC {
    
    @IBOutlet weak var collectionViewForImage: UICollectionView!
    @IBOutlet weak var collectionViewForGrid: UICollectionView!
    var viewModel = AboutUsVM()
    let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getImageNames()
        viewModel.getGridCVData()
        print("About Loaded")

    }
    
    @IBAction func didPressRightButton(_ button: UIButton){
        let visibleItems = collectionViewForImage.indexPathsForVisibleItems as Array
        guard let currentItem = visibleItems[0] as? IndexPath else { fatalError() }
        let nextItemNo = (currentItem.item + 1) % viewModel.imageNames.count
        let nextItem = IndexPath(item: nextItemNo, section: 0)
        if nextItem.row < viewModel.imageNames.count {
            collectionViewForImage.scrollToItem(at: nextItem, at: .right, animated: true)
        }
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("About Appeared")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("About Disappeared")
    }
    
    @IBAction func didPressLeftButton(_ button: UIButton){
        let visibleItems: NSArray = collectionViewForImage.indexPathsForVisibleItems as NSArray
        guard let currentItem = visibleItems.object(at: 0) as? IndexPath else { fatalError() }
        var nextItemNo = (currentItem.item - 1) % viewModel.imageNames.count
        if nextItemNo == -1{
            nextItemNo = viewModel.imageNames.count-1
        }
        let nextItem = IndexPath(item: nextItemNo, section: 0)
        if nextItem.row < viewModel.imageNames.count {
            collectionViewForImage.scrollToItem(at: nextItem, at: .right, animated: true)
        }
    }
}

extension AboutUsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewForImage{
            return viewModel.imageNames.count
        }
        return viewModel.gridLayoutData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewForImage{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AboutUsCVCell.self), for: indexPath) as? AboutUsCVCell
            cell?.imageView.image = UIImage(named: viewModel.imageNames[indexPath.row].imageName)
            return cell ?? UICollectionViewCell()
        }
        else if collectionView == self.collectionViewForGrid{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AboutUsDescriptionCVCell.self), for: indexPath) as? AboutUsDescriptionCVCell
            cell?.backgroundColor = UIColor.randomClr()
            cell?.imageView.image = UIImage(named: viewModel.gridLayoutData[indexPath.row].imageName)
            cell?.label.text = viewModel.gridLayoutData[indexPath.row].label
            return cell ?? UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewForImage{
            return collectionView.frame.size
        }
        let cellsPerRow = CGFloat(3)
        let availableWidth = collectionView.frame.size.width - sectionInsets.left
        let widthPerItem = availableWidth / cellsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}

extension UIColor{
    static func randomClr() -> UIColor{
        return UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1.0)
    }
}
