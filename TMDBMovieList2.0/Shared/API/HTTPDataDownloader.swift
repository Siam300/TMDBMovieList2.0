//
//  HTTPDataDownloader.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 29/12/23.
//

import Foundation

protocol HTTPDataDownloader {
    func fetchData<T: Decodable>(as type: T.Type, endpoint: String) async throws -> T
}

extension HTTPDataDownloader {
    func fetchData<T>(as type: T.Type, endpoint: String) async throws -> T where T : Decodable {        guard let url = URL(string: endpoint) else {
        throw MovieAPIError.requestFailed(description: "Invalid URL")
    }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw MovieAPIError.requestFailed(description: "Request failed")
        }
        
        guard httpResponse.statusCode == 200 else {
            throw MovieAPIError.invalidStatusCode(description: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(type.self, from: data)
        } catch {
            print("Debug: Error \(error)")
            throw error as? MovieAPIError ?? .unknownError(error: error)
        }
    }
}
