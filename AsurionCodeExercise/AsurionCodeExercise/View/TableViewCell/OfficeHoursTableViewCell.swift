//
//  OfficeHoursTableViewCell.swift
//  AsurionCodeExercise
//
//  Created by Goel, Shobit on 02/10/20.
//  Copyright © 2020 Goel, Shobit. All rights reserved.
//

import UIKit

class OfficeHoursTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "OfficeHoursTableViewCell"
    
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var officeHoursLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor.lightGray.cgColor
    }
}
