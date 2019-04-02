//
//  ChatTableViewCell.swift
//  Chatter
//
//  Created by Harjas Monga on 4/2/19.
//  Copyright © 2019 Harjas Monga. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var messageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageView.layer.cornerRadius = 16
        messageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
