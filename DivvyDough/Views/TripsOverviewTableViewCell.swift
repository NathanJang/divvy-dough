//
//  TripsOverviewTableViewCell.swift
//  DivvyDough
//
//  Created by Jonathan Chan on 2017-10-07.
//  Copyright © 2017 Jonathan Chan. All rights reserved.
//

import UIKit

class TripsOverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var tripNameLabel: UILabel!
    @IBOutlet weak var groupMembersLabel: UILabel!
    @IBOutlet weak var dateRangeLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        balanceLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
