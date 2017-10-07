//
//  TransactionOverviewTableViewCell.swift
//  DivvyDough
//
//  Created by Jonathan Chan on 2017-10-07.
//  Copyright © 2017 Jonathan Chan. All rights reserved.
//

import UIKit

class TransactionOverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var transactionNameLabel: UILabel!
    @IBOutlet weak var transactionTimeLabel: UILabel!
    @IBOutlet weak var transactionAmountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        transactionAmountLabel.textColor = .red
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
