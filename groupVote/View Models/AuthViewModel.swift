//
//  AuthViewModel.swift
//  groupVote
//
//  Created by Alaa . on 05/08/2023.
//

import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var users = User(id: UUID(), name: "")
    
    
}

extension WebAPI {
    static func userSignedIn() -> Bool {
         if ((self.accessToken?.isEmpty) == nil) {
             accessToken = UserDefaults.standard.string(forKey: "accessToken")
         }
        guard self.accessToken != nil
         else {
             return false
         }
        return true
     }
    
    static func authorize(
      identityToken: Data?,
      name: String,
      completion: @escaping (Result<User, Error>) -> Void
    ) {

      guard let identityToken = identityToken else {
        completion(.failure(WebAPIError.identityTokenMissing))
        return
      }

      guard let identityTokenString = String(data: identityToken, encoding: .utf8) else {
        completion(.failure(WebAPIError.unableToDecodeIdentityToken))
        return
      }

      let body = UserInput(name: name)

      guard let jsonBody = try? JSONEncoder().encode(body) else {
        completion(.failure(WebAPIError.unableToEncodeJSONData))
        return
      }

      let session = URLSession.shared
      let url = URL(string: "\(baseURL)/api/users")!
      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")

      session.uploadTask(with: request, from: jsonBody) { (data, response, error) in
        do {
          let userResponse: UserResponse = try parseResponse(response, data: data, error: error)
          accessToken = userResponse.accessToken
           UserDefaults.standard.set(self.accessToken, forKey: "accessToken")
          completion(.success(userResponse.user))
        } catch {
          completion(.failure(error))
        }
      }.resume()
    }
    
    static func getProfile(
      completion: @escaping (Result<User, Error>) -> Void
    ) {

      guard let accessToken = Self.accessToken else {
          // if not in core data
          
        completion(.failure(WebAPIError.unauthorized))
        return
      }
        
      let session = URLSession.shared
      let url = URL(string: "\(baseURL)/api/users/me")!
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")

      session.dataTask(with: request) { (data, response, error) in
        do {
          let userResponse: UserResponse = try parseResponse(response, data: data, error: error)
          completion(.success(userResponse.user))
            
        } catch {
          completion(.failure(error))
        }
      }.resume()
    }
}
