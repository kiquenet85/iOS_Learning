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
        static var sessionId = ""
    }
    
    enum Endpoints {
        
        static let base = "https://onthemap-api.udacity.com/v1/"
        
        case login
        
        
        var stringValue: String {
            switch self {
                
            case .login: return Endpoints.base + "/session"
                
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func login (_ username: String, _ password: String, completion: @escaping (Bool, Error?) -> Void){
        taskForGetRequest(url: Endpoints.login.url, response: UdacityLoginResponse.self){
            (response, error) in
            
            if response != nil{
                completion(true, nil)
            } else {
                completion(false, error)
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
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                completion(responseObject, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
        return task
    }
    
    class func taskForPostRequest<RequestType: Encodable, ResponseType: Codable>(url: URL, body: RequestType, response: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void){
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            urlRequest.httpBody = try JSONEncoder().encode(body)
        } catch {
            completion(nil, error)
            return
        }
        
        print(urlRequest)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let responsePostObject = try decoder.decode(ResponseType.self, from: data)
                completion(responsePostObject, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    class func taskForDeleteRequest<RequestType: Encodable, ResponseType: Decodable> (url: URL, body: RequestType, response: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "DELETE"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            urlRequest.httpBody = try JSONEncoder().encode(body)
        } catch {
            completion(nil, error)
            return
        }
        
        print(urlRequest)
        URLSession.shared.dataTask(with: urlRequest){
            (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            let json = JSONDecoder()
            do {
                let responseObJect = try json.decode(ResponseType.self, from: data)
                completion(responseObJect, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
