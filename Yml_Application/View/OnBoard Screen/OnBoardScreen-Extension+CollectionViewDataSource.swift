import Foundation
import UIKit

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.onBoardScreenData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionViewCell.self), for: indexPath) as? CollectionViewCell
        cell?.image.image = UIImage(named: viewModel.onBoardScreenData[indexPath.row].bgImageName)
        cell?.productLogo.image = UIImage(named: viewModel.onBoardScreenData[indexPath.row].productLogoName)
        cell?.productLogo.clipsToBounds = true
        cell?.productLogo.layer.cornerRadius = 9.0
        cell?.productDescription.text = viewModel.onBoardScreenData[indexPath.row].productDescriptionName
        cell?.productDescription.adjustsFontSizeToFitWidth = true
        cell?.productTitle.text = viewModel.onBoardScreenData[indexPath.row].productTitleName
        return cell ?? UICollectionViewCell()
    }
}

