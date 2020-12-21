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
        
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case login
        case getLocations
        
        
        var stringValue: String {
            switch self {
                
            case .login: return Endpoints.base + "/session"
            case .getLocations: return Endpoints.base + "/StudentLocation?limit=100"
                
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
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
                    Auth.sessionId = response!.session.id!
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
            
            /*let range = 5..<data.count
            let newData = data.subdata(in: range)*/
            
            
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
            let range = 5..<data.count
            let newData = data.subdata(in: range)
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
    
    class func taskForDeleteRequest<RequestType: Encodable, ResponseType: Decodable> (url: URL, body: RequestType, response: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "DELETE"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
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
            guard data != nil else {
                completion(nil, error)
                return
            }
            let range = 5..<data!.count
            let newData = data!.subdata(in: range)
            
            let decoder = JSONDecoder()
            do {
                let commonResponse = try decoder.decode(CommonResponse.self, from: newData)
                if (commonResponse.status == 200){
                    completion(nil, commonResponse)
                } else {
                    completion(nil, commonResponse)
                }
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
