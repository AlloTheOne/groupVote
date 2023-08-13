//
//  WebAPI.swift
//  groupVote
//
//  Created by Alaa . on 05/08/2023.
//

import Foundation


struct WebAPI {
    static let baseURL = "http://127.0.0.1:8080"
    static var accessToken: String?

    enum WebAPIError: Error {
      case identityTokenMissing
      case unableToDecodeIdentityToken
      case unableToEncodeJSONData
      case unableToDecodeJSONData
      case unauthorized
      case invalidResponse
      case httpError(statusCode: Int)
    }
}


extension WebAPI {

  static func parseResponse<T: Decodable>(_ response: URLResponse?, data: Data?, error: Error?) throws -> T {
    if let error = error {
      throw error
    }

    guard let httpResponse = response as? HTTPURLResponse else {
      throw WebAPIError.invalidResponse
    }

    if !(200...299).contains(httpResponse.statusCode) {
      throw WebAPIError.httpError(statusCode: httpResponse.statusCode)
    }

    guard let data = data, let decoded = try? JSONDecoder().decode(T.self, from: data) else {
      throw WebAPIError.unableToDecodeJSONData
    }
    return decoded
  }
}
