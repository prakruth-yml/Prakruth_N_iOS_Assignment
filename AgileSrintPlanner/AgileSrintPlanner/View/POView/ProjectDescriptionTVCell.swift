//
//  ProjectDescriptionCVCell.swift
//  AgileSrintPlanner
//
//  Created by Prakruth Nagaraj on 09/09/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class ProjectDescriptionTVCell: BaseTVCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textToDisplay: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textToDisplay.textContainer.maximumNumberOfLines = 10
    }
    
}
