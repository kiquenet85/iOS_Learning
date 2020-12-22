//
//  UserLocation.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 12/20/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import Foundation

struct UserLocation: Codable {
    let firstName: String
    let lastName: String
    let longitude: Double
    let latitude: Double
    let mapString: String
    let mediaURL: String
    let uniqueKey: String
    let objectId: String?
    let createdAt: String? = nil
    let updatedAt: String? = nil
    
    func getUserLocationWithUserAuthInfo(authUniqueKey: String, currentObjectId: String) -> UserLocation {
        return UserLocation(firstName: self.firstName, lastName: self.lastName, longitude: self.longitude, latitude: self.latitude, mapString: self.mapString, mediaURL: self.mediaURL, uniqueKey: authUniqueKey, objectId: currentObjectId)
    }
}
