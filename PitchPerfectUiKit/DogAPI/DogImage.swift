//
//  DogImage.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 9/26/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import Foundation
import UIKit

struct DogImage: Codable {
    let status: String
    let message: String
}

struct DogBreed: Codable {
    let status: String
    let breeds: [String:[String]]
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case breeds = "message"
    }
}

enum DogService : String, CaseIterable {
    case TOY_POODLE = "https://dog.ceo/api/breed/poodle/toy/images/random"
    case DOG_BREEDS = "https://dog.ceo/api/breeds/list/all"
    case DOG_SELECTION_BREED_FORMAT = "https://dog.ceo/api/breed/%@/images/random"
    
    static func requestRandomImage(url: URL, completionHandler: @escaping (DogImage?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, urlResponse, error) in
            
            guard let data = data else {
                completionHandler(nil, DogServiceError("data from service \(url) is nil"))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let dogImage = try decoder.decode(DogImage.self, from: data)
                completionHandler(dogImage, nil)
            } catch {
                completionHandler(nil, error)
            }
        }.resume()
    }
}


class DogServiceError: NSObject, LocalizedError {
    var desc = ""
    init(_ errorDesc: String) {
        desc = errorDesc
    }
    override var description: String {
        get {
            return "DogServiceError: \(desc)"
        }
    }
    //You need to implement `errorDescription`, not `localizedDescription`.
    var errorDescription: String? {
        get {
            return self.description
        }
    }
}
