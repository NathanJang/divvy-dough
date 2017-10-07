//
//  UserTableViewCell.swift
//  DivvyDough
//
//  Created by Jonathan Chan on 2017-10-07.
//  Copyright © 2017 Jonathan Chan. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        balanceLabel.textColor = .green
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
