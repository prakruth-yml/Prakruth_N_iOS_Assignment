//
//  TeamMembersTVCell.swift
//  AgileSrintPlanner
import UIKit

class TeamMembersTVCell: BaseTVCell , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
//    var projectDeta
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        collectionView.dataSource = self
//        collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return projectDetails?.teamMember.count ?? 0
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TeamDisplayCVCell.self), for: indexPath) as? TeamDisplayCVCell else { return TeamDisplayCVCell() }

        cell.imageView.image = UIImage(named: "Teamwork-Theme")
        cell.nameLabel.text = "projectDetails?.teamMember[indexPath.row].name"
        cell.roleLabel.text = "projectDetails?.teamMember[indexPath.row].role"

        return cell
    }
}
