//
//  GroupViewModel.swift
//  groupVote
//
//  Created by Alaa . on 05/08/2023.
//

import Foundation


extension WebAPI {
//    static func postGroup(type: String?,
//                          tie: Bool,
//                          close: Bool,
//                          end: Bool,
//    completion: @escaping (Result<Group, Error>) -> Void ){
//
//
////        if ((self.accessToken?.isEmpty) == nil) {
////            accessToken = UserDefaults.standard.string(forKey: "accessToken")
////        }
//        guard self.accessToken != nil
//        else {
//              completion(.failure(WebAPIError.unauthorized))
//              return
//        }
//    }
    // MARK: - join group 
    static func joinGroup(join_id: Int,
                          completion: @escaping (Result<Group, Error>) -> Void ) {
//        if ((self.accessToken?.isEmpty) == nil) {
//            accessToken = UserDefaults.standard.string(forKey: "accessToken")
//        }
        guard let accessToken = self.accessToken
        else {
              completion(.failure(WebAPIError.unauthorized))
              return
        }
        
        let session = URLSession.shared
        let url = URL(string: "\(baseURL)/api/groups/\(join_id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: request) { (data, response, error) in
            do {
                let orderResponse: GroupResponse = try parseResponse(response, data: data, error: error)
                
                completion(.success(orderResponse.group))
            } catch {
                completion(.failure(error))
            }
          }.resume()
        
    }
    
    // get group
    static func getGroupByID(groupID: UUID,
                             completion: @escaping (Result<Group, Error>) -> Void) {
        guard let accessToken = self.accessToken else {
              completion(.failure(WebAPIError.unauthorized))
              return
        }
        let session = URLSession.shared
        let url = URL(string: "\(baseURL)/api/groups/\(groupID)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: request) { (data, response, error) in
            do {
                let orderResponse: GroupResponse = try parseResponse(response, data: data, error: error)
                
                completion(.success(orderResponse.group))
            } catch {
                completion(.failure(error))
            }
          }.resume()
    }
    // get all group stuff
    static func getAllGroupStuffByID(groupID: UUID,
                             completion: @escaping (Result<Group, Error>) -> Void) {
        guard let accessToken = self.accessToken else {
              completion(.failure(WebAPIError.unauthorized))
              return
        }
        let session = URLSession.shared
        let url = URL(string: "\(baseURL)/api/groups/all/\(groupID)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: request) { (data, response, error) in
            do {
                let orderResponse: GroupResponse = try parseResponse(response, data: data, error: error)
                
                completion(.success(orderResponse.group))
            } catch {
                completion(.failure(error))
            }
          }.resume()
    }
}
