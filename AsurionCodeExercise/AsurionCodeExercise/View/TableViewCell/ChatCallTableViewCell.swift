//
//  ChatCallTableViewCell.swift
//  AsurionCodeExercise
//
//  Created by Goel, Shobit on 02/10/20.
//  Copyright © 2020 Goel, Shobit. All rights reserved.
//

import UIKit

enum PresentationStyle {
    case chat
    case call
}

class ChatCallTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "ChatCallTableViewCell"
    
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    
    func setPresentationStyle(_ style: PresentationStyle) {
        switch style {
        case .chat:
            self.callButton?.removeFromSuperview()
        case .call:
            self.chatButton?.removeFromSuperview()
        }
    }
}
