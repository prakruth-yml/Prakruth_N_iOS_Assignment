import UIKit

class AddNewStoryTextViewTVCell: BaseTVCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descpTextView: UITextView!
    @IBOutlet weak var hiddenTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descpTextView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(title: String) {
        titleLabel.text = title
        descpTextView.layer.borderWidth = 1.0
        descpTextView.layer.borderColor = UIColor.lightGray.cgColor
        descpTextView.layer.cornerRadius = 7.0
        hiddenTextLabel.text = titleLabel.text
    }
}

extension AddNewStoryTextViewTVCell: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        hiddenTextLabel.isHidden = true
        return true
    }
}
