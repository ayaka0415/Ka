//
//  TableViewCell.swift
//  Kiroku
//
//  Created by Owner on 2020/06/25.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var mitaNamaeLabel: UILabel!
    @IBOutlet weak var mitaScoreLabel: UILabel!
    @IBOutlet weak var mitaTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
