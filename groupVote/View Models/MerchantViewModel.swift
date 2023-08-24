//
//  MerchantViewModel.swift
//  groupVote
//
//  Created by Alaa . on 05/08/2023.
//

import Foundation

extension WebAPI {
    
    // MARK: - create new group + merchant
    static func postMerchantGroup(name: String,
                                  completion: @escaping (Result<Merchant_Group, Error>) -> Void ){
        
        // authenticate
        guard let accessToken = self.accessToken
            else {
              completion(.failure(WebAPIError.unauthorized))
              return
        }
        
        let body = MerchantInput(name: name)
        print("name:", name)
        guard let jsonBody = try? JSONEncoder().encode(body) else {
          completion(.failure(WebAPIError.unableToEncodeJSONData))
          return
        }
        
        let session = URLSession.shared
        let url = URL(string: "\(baseURL)/api/merchants")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
                  let decoded = try? JSONDecoder().decode(Merchant_Group.self, from: data)
                  else {
                    throw WebAPIError.unableToDecodeJSONData
                  }
                print("here again", decoded)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    // MARK: - post merchant
    static func postMerchant(name: String,
                             groupID: UUID,
                             completion: @escaping (Result<Merchant, Error>) -> Void ) {
        // authenticate
        if ((self.accessToken?.isEmpty) == nil) {
            accessToken = UserDefaults.standard.string(forKey: "accessToken")
        }
        guard let accessToken = self.accessToken
        else {
              completion(.failure(WebAPIError.unauthorized))
              return
        }
        
        let body = MerchantInput(name: name)
        
        guard let jsonBody = try? JSONEncoder().encode(body) else {
          completion(.failure(WebAPIError.unableToEncodeJSONData))
          return
        }
        
        let session = URLSession.shared
        let url = URL(string: "\(baseURL)/api/merchants/\(groupID)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
                  let decoded = try? JSONDecoder().decode(Merchant.self, from: data)
                  else {
                    throw WebAPIError.unableToDecodeJSONData
                  }
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
        
    }

    // MARK: - Add vote
    static func addVote(merchantID: UUID, completion: @escaping (Result<Merchant, Error>) -> Void) {
        guard let accessToken = self.accessToken
                else {
                      completion(.failure(WebAPIError.unauthorized))
                      return
                }
        
        let session = URLSession.shared
        let url = URL(string: "\(baseURL)/api/merchants/add/\(merchantID)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
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
                  let decoded = try? JSONDecoder().decode(Merchant.self, from: data)
                  else {
                    throw WebAPIError.unableToDecodeJSONData
                  }
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
          }.resume()
    }
    // MARK: - get winner merchant
    static func getWinnerMerchant(groupID: UUID,
                             completion: @escaping (Result<BaseMerchant, Error>) -> Void) {
        guard let accessToken = self.accessToken else {
              completion(.failure(WebAPIError.unauthorized))
              return
        }
        print("group id in get group", groupID)
        let session = URLSession.shared
        let url = URL(string: "\(baseURL)/api/merchants/winner/\(groupID)")!
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
                  let decoded = try? JSONDecoder().decode(BaseMerchant.self, from: data)
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
