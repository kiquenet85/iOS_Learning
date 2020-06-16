//
//  Meme.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 6/15/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var topText: String
    var bottomText: String
    weak var originalImage: UIImage?
    weak var memedImage : UIImage?
    
    init(topText: String, bottomText: String, originalImage: UIImage?, memedImage: UIImage?) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
}
