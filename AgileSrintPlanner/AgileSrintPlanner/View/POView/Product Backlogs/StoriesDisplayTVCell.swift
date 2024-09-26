//
//  StoriesDisplayTVCell.swift
//  AgileSrintPlanner
//
//  Created by Prakruth Nagaraj on 14/09/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class StoriesDisplayTVCell: BaseTVCell {

    @IBOutlet weak var storyIdLabel: UILabel!
    @IBOutlet weak var storyTitleLabel: UILabel!
    @IBOutlet weak var storyDescriptionLabel: UILabel!
    @IBOutlet weak var storyStatusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
