//
//  MessageCellTableViewCell.swift
//  gitCode
//
//  Created by Dimitar Vitanov on 7/8/19.
//  Copyright © 2019 Dimitar Vitanov. All rights reserved.
//

import UIKit

class MessageCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var messageBackground: UIView!
    @IBOutlet weak var messageBody: UILabel!
    @IBOutlet weak var senderUsername: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
