//
//  MemeTableViewCell.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 7/7/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memeImg: UIImageView!
    @IBOutlet weak var memeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
