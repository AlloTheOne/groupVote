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
                          completion: @escaping (Result<BaseGroup, Error>) -> Void ) {
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
                if let error = error {
                  throw error
                }
                  guard let httpResponse = response as? HTTPURLResponse else {
                    throw WebAPIError.invalidResponse
                  }
                  if !(200...299).contains(httpResponse.statusCode) {
                    throw WebAPIError.httpError(statusCode: httpResponse.statusCode)
                  }
                  guard let data = data,
                  let decoded = try? JSONDecoder().decode(BaseGroup.self, from: data)
                  else {
                    throw WebAPIError.unableToDecodeJSONData
                  }
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
          }.resume()
        
    }
    
    // get group
    static func getGroupByID(groupID: UUID,
                             completion: @escaping (Result<BaseGroup, Error>) -> Void) {
        guard let accessToken = self.accessToken else {
              completion(.failure(WebAPIError.unauthorized))
              return
        }
        print("group id in get group", groupID)
        let session = URLSession.shared
        let url = URL(string: "\(baseURL)/api/groups/\(groupID)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: request) { (data, response, error) in
            do {
                if let error = error {
                  throw error
                }
                  guard let httpResponse = response as? HTTPURLResponse else {
                    throw WebAPIError.invalidResponse
                  }
                  if !(200...299).contains(httpResponse.statusCode) {
                    throw WebAPIError.httpError(statusCode: httpResponse.statusCode)
                  }
                  guard let data = data,
                  let decoded = try? JSONDecoder().decode(BaseGroup.self, from: data)
                  else {
                    throw WebAPIError.unableToDecodeJSONData
                  }
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
          }.resume()
    }
    // get all group stuff
    static func getAllGroupStuffByID(groupID: UUID,
                             completion: @escaping (Result<[BaseMerchant_Group], Error>) -> Void) {
        guard let accessToken = self.accessToken else {
              completion(.failure(WebAPIError.unauthorized))
              return
        }
        print("group id in function:", groupID)
        let session = URLSession.shared
        let url = URL(string: "\(baseURL)/api/groups/all/\(groupID)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: request) { (data, response, error) in
            do {
                if let error = error {
                  throw error
                }
                  guard let httpResponse = response as? HTTPURLResponse else {
                    throw WebAPIError.invalidResponse
                  }
                  if !(200...299).contains(httpResponse.statusCode) {
                    throw WebAPIError.httpError(statusCode: httpResponse.statusCode)
                  }
                  guard let data = data,
                  let decoded = try? JSONDecoder().decode([BaseMerchant_Group].self, from: data)
                  else {
                    throw WebAPIError.unableToDecodeJSONData
                  }
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
          }.resume()
    }
    
    static func getAllUsersByID(groupID: UUID,
                             completion: @escaping (Result<[User], Error>) -> Void) {
        guard let accessToken = self.accessToken else {
              completion(.failure(WebAPIError.unauthorized))
              return
        }
//        print("group id in function:", groupID)
        let session = URLSession.shared
        let url = URL(string: "\(baseURL)/api/groups/users/\(groupID)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: request) { (data, response, error) in
            do {
                if let error = error {
                  throw error
                }
                  guard let httpResponse = response as? HTTPURLResponse else {
                    throw WebAPIError.invalidResponse
                  }
                  if !(200...299).contains(httpResponse.statusCode) {
                    throw WebAPIError.httpError(statusCode: httpResponse.statusCode)
                  }
                  guard let data = data,
                  let decoded = try? JSONDecoder().decode([User].self, from: data)
                  else {
                    throw WebAPIError.unableToDecodeJSONData
                  }
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
          }.resume()
    }
    //update group
    static func updateGroup(groupID: UUID, tie: Bool?, close: Bool?, end: Bool?, completion: @escaping (Result<Group, Error>) -> Void) {
        guard let accessToken = self.accessToken else {
              completion(.failure(WebAPIError.unauthorized))
              return
        }
        let body = UpdateGroupInput(groupID: groupID, tie: tie, close: close, end: end)
        
        
        guard let jsonBody = try? JSONEncoder().encode(body) else {
          completion(.failure(WebAPIError.unableToEncodeJSONData))
          return
        }
        let session = URLSession.shared
        let url = URL(string: "\(baseURL)/api/groups")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.uploadTask(with: request, from: jsonBody) { (data, response, error) in
            do {
                if let error = error {
                  throw error
                }
                  guard let httpResponse = response as? HTTPURLResponse else {
                    throw WebAPIError.invalidResponse
                  }
                  if !(200...299).contains(httpResponse.statusCode) {
                    throw WebAPIError.httpError(statusCode: httpResponse.statusCode)
                  }
                  guard let data = data,
                  let decoded = try? JSONDecoder().decode(Group.self, from: data)
                  else {
                    throw WebAPIError.unableToDecodeJSONData
                  }
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

struct UpdateGroupInput: Codable {
    let groupID: UUID
    var tie: Bool?
    var close: Bool?
    var end: Bool?
}
