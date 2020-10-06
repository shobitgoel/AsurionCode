//
//  PetInfoTableViewCell.swift
//  AsurionCodeExercise
//
//  Created by Goel, Shobit on 02/10/20.
//  Copyright © 2020 Goel, Shobit. All rights reserved.
//

import UIKit

class PetInfoTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "PetInfoTableViewCell"
    
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petNameLabel: UILabel!
}
