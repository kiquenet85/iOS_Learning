//
//  PickerAppViewController.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 5/30/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import UIKit

class AppViewCell: UITableViewCell {
    
    @IBOutlet weak var appLabel: UILabel!
    @IBOutlet weak var appImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
