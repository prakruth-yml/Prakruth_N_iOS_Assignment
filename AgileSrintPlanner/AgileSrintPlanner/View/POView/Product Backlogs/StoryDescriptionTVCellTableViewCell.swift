//
//  StoryDescriptionTVCellTableViewCell.swift
//  AgileSrintPlanner
//
//  Created by Prakruth Nagaraj on 17/09/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class StoryDescriptionTVCellTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descpLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
