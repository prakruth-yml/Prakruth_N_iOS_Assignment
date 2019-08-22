//
//  WorkVCTableViewCell.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 22/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class WorkVCTableViewCell: UITableViewCell {
    
    @IBOutlet weak var workImage: UIImageView!
    @IBOutlet weak var workTitle: UILabel!
    @IBOutlet weak var workDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
