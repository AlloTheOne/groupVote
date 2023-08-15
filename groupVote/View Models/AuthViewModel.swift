//
//  AuthViewModel.swift
//  groupVote
//
//  Created by Alaa . on 05/08/2023.
//

import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var users = User(id: UUID(), name: String())
    
    
}

extension WebAPI {
    static func userSignedIn() -> Bool {
         if ((self.accessToken?.isEmpty) == nil) {
             accessToken = UserDefaults.standard.string(forKey: "accessToken")
//             print("access token", accessToken)
         }
        guard self.accessToken != nil
         else {
            print("not signed in")
             return false
         }
        print("signed in")
        return true
     }
    
    static func authorize(
      name: String,
      completion: @escaping (Result<Token, Error>) -> Void
    ) {


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
              let decoded = try? JSONDecoder().decode(Token.self, from: data)
              else {
                throw WebAPIError.unableToDecodeJSONData
              }
            accessToken = decoded.value
            UserDefaults.standard.set(self.accessToken, forKey: "accessToken")

    completion(.success(decoded))
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
