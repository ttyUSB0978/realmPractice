//
//  TestTableViewCell.swift
//  realmTest
//
//  Created by Jake Lin on 03/04/2018.
//  Copyright © 2018 ttyUSB0978. All rights reserved.
//

import UIKit

class TestTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var jobLabel: UILabel!
    @IBOutlet var expLabel: UILabel!
    @IBOutlet var testImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
