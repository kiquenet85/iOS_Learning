//
//  CommonErrorResponse.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 12/20/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import Foundation

struct CommonResponse: Codable {
    let status: Int
    let error: String
}

extension CommonResponse : LocalizedError {
    var errorDescription: String? {
        return error
    }
}
