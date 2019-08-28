//
//  CarrersTableVIewCell.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 26/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class CarrersTableVIewCell: BaseTVCell {
    
    @IBOutlet weak var domain: UILabel!
    @IBOutlet weak var role: UILabel!
    @IBOutlet weak var location: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
