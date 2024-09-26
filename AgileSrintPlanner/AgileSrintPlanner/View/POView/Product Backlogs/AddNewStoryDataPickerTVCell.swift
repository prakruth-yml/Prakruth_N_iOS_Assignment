//
//  AddNewStoryDataPickerTVCell.swift
//  AgileSrintPlanner
//
//  Created by Prakruth Nagaraj on 16/09/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class AddNewStoryDataPickerTVCell: BaseTVCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fieldDataPicker: UIPickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(title: String) {
        titleLabel.text = title
        fieldDataPicker.layer.borderColor = UIColor.lightGray.cgColor
        fieldDataPicker.layer.borderWidth = 1.0
        fieldDataPicker.layer.cornerRadius = 7.0
    }

}
