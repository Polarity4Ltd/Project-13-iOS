//
//  TableViewCell1TableViewCell.swift
//  Project Thirteen
//
//  Created by Alex Pilcher on 15/07/2019.
//  Copyright © 2019 Alex Pilcher. All rights reserved.
//

import UIKit

class TableViewCell1TableViewCell: UITableViewCell {
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageTypeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
