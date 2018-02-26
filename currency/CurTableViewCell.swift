//
//  CurTableViewCell.swift
//  currency
//
//  Created by Hameleonlab on 26.02.18.
//  Copyright © 2018 hameleonlab. All rights reserved.
//

import UIKit

class CurTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
