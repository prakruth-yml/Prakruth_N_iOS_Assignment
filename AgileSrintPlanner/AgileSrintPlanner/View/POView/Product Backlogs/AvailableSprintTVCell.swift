//
//  AvailableSprintTVCell.swift
//  AgileSrintPlanner
//
//  Created by Prakruth Nagaraj on 18/09/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class AvailableSprintTVCell: BaseTVCell {

    @IBOutlet weak var storyIDLabel: UILabel!
    @IBOutlet weak var storyTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
