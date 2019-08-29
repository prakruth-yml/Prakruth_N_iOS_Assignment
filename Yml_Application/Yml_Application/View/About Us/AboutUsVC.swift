import UIKit
import AVFoundation

class AboutUsVC: BaseVC {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel = AboutUsVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getImageNames()

    }
    
    @IBAction func didPressRightButton(_ button: UIButton){
        
//        let visibleItems: NSArray = collectionView.indexPathsForVisibleItems as NSArray
//        guard let currentItem = visibleItems.object(at: 0) as? IndexPath else { fatalError() }
//        let nextItem = IndexPath(item: currentItem.item + 1, section: 0)
//        if nextItem.row < viewModel.imageNames.count {
//            collectionView.scrollToItem(at: nextItem, at: .right, animated: true)
//        }
//
        let visibleItems = collectionView.indexPathsForVisibleItems as Array
        guard let currentItem = visibleItems[0] as? IndexPath else { fatalError() }
//        guard let currentItem = visibleItems.object(at: 0) as? IndexPath else { fatalError() }
        let nextItem = IndexPath(item: currentItem.item + 1, section: 0)
        if nextItem.row < viewModel.imageNames.count {
            collectionView.scrollToItem(at: nextItem, at: .right, animated: true)
        }
        

    }
    
    @IBAction func didPressLeftButton(_ button: UIButton){
        let visibleItems: NSArray = collectionView.indexPathsForVisibleItems as NSArray
        guard let currentItem = visibleItems.object(at: 0) as? IndexPath else { fatalError() }
        let nextItem = IndexPath(item: currentItem.item + 1, section: 0)
        if nextItem.row < viewModel.imageNames.count {
            collectionView.scrollToItem(at: nextItem, at: .right, animated: true)
        }
    }
}

extension AboutUsVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AboutUsCVCell.self), for: indexPath) as? AboutUsCVCell
        cell?.imageView.image = UIImage(named: viewModel.imageNames[indexPath.row].imageName)
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    
}
