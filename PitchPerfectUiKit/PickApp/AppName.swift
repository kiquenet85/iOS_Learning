//
//  AppNames.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 5/30/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import Foundation
import UIKit

struct AppName {
    var name : String
    var photo: UIImage?
    
    init(name: String, image: UIImage?) {
        self.name = name
        self.photo = image
    }
}
