//
//  File.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 12/20/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import Foundation

class UdacityClient {
    
    struct Auth {
        static var SESSION_ID = ""
        static var UNIQUE_ID = ""
        static var OBJECT_ID = ""
    }
    
    enum Endpoints {
        
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case login
        case getLocations
        case getUserLocation
        
        case postUserLocation
        case updateUserLocation
        
        
        var stringValue: String {
            switch self {
                
            case .login: return Endpoints.base + "/session"
            case .getLocations: return Endpoints.base + "/StudentLocation?limit=100"
            case .getUserLocation: return Endpoints.base + "/StudentLocation?uniqueKey=\(Auth.UNIQUE_ID)"
                
            case .postUserLocation: return Endpoints.base + "/StudentLocation"
            case .updateUserLocation: return Endpoints.base + "/StudentLocation/\(Auth.OBJECT_ID)"
                
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func updateUserLocation (newUserLocation: UserLocation, completion: @escaping (Bool, Error?) -> Void){
        let userLocation = newUserLocation.getUserLocationWithUserAuthInfo(authUniqueKey: Auth.UNIQUE_ID, currentObjectId: Auth.OBJECT_ID)
        let url = Endpoints.updateUserLocation.url
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let bytes = try! JSONEncoder().encode(userLocation)
        request.httpBody = bytes
        print(String(data: bytes, encoding: .utf8)!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            print(String(data: data!, encoding: .utf8)!)
            
            let decoder = JSONDecoder()
            
            do {
                try decoder.decode(UpdateUserLocationResponse.self, from: data!)
                DispatchQueue.main.async {
                    completion(true, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(false, error)
                }
            }
        }
        task.resume()
    }
    
    class func postUserLocation (newUserLocation: UserLocation, completion: @escaping (Bool, Error?) -> Void){
        let userLocation = newUserLocation.getUserLocationWithUserAuthInfo(authUniqueKey: Auth.UNIQUE_ID, currentObjectId: Auth.OBJECT_ID)
        taskForPostRequest(url: Endpoints.postUserLocation.url, body: userLocation, response: CreateUserLocationResponse.self){
            (response, error) in
            
            DispatchQueue.main.async {
                if response != nil{
                    completion(true, nil)
                } else {
                    completion(false, error)
                }
            }
        }
    }
    
    class func getUserLocation(completion: @escaping (UserLocation?, Error?) -> Void) {
        taskForGetRequest(url: Endpoints.getUserLocation.url, response: UserLocationResponse.self) {
            (userLocationResponse, error) in
            
            DispatchQueue.main.async {
                if userLocationResponse != nil{
                    Auth.OBJECT_ID = userLocationResponse!.results[0].objectId!
                    completion(userLocationResponse?.results[0], nil)
                } else {
                    completion(nil, error)
                }
            }
        }
    }
    
    class func getLocations(completion: @escaping ([UserLocation]?, Error?) -> Void) {
        taskForGetRequest(url: Endpoints.getLocations.url, response: UserLocationResponse.self) {
            (userLocationResponse, error) in
            
            DispatchQueue.main.async {
                if userLocationResponse != nil{
                    completion(userLocationResponse?.results, nil)
                } else {
                    completion(nil, error)
                }
            }
        }
    }
    
    class func login (_ username: String, _ password: String, completion: @escaping (Bool, Error?) -> Void){
        let body = UdacityLoginRequest(udacity: UdacityDTO(username: username, password: password))
        
        taskForPostRequest(url: Endpoints.login.url, body: body, response: UdacityLoginResponse.self){
            (response, error) in
            
            DispatchQueue.main.async {
                if response != nil{
                    Auth.SESSION_ID = response!.session.id!
                    Auth.UNIQUE_ID = response!.account.key!
                    completion(true, nil)
                } else {
                    completion(false, error)
                }
            }
        }
    }
    
    
    @discardableResult
    class func taskForGetRequest<ResponseType: Decodable>(url: URL, response: ResponseType.Type,
                                                          completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask {
        print(url)
        let task =  URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            print(String(data: data, encoding: .utf8)!)
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                completion(responseObject, nil)
            } catch {
                do {
                    let responseErrorObject = try decoder.decode(CommonResponse.self, from: data)
                    completion(nil, responseErrorObject)
                } catch {
                    completion(nil, error)
                }
            }
        }
        task.resume()
        return task
    }
    
    class func taskForPostRequest<RequestType: Encodable, ResponseType: Codable>(url: URL, body: RequestType, response: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void){
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            urlRequest.httpBody = try JSONEncoder().encode(body)
        } catch {
            completion(nil, error)
            return
        }
        
        print(urlRequest)
        let bytes = try! JSONEncoder().encode(body)
        print(String(data: bytes, encoding: .utf8)!)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            var newData = data
            if (url == Endpoints.login.url){
                let range = 5..<data.count
                newData = data.subdata(in: range)
            }
            
            print(String(data: newData, encoding: .utf8)!)
            
            let decoder = JSONDecoder()
            do {
                let responsePostObject = try decoder.decode(ResponseType.self, from: newData)
                completion(responsePostObject, nil)
            } catch {
                do {
                    let responseErrorObject = try decoder.decode(CommonResponse.self, from: newData)
                    completion(nil, responseErrorObject)
                } catch {
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
