//
//  SearchService.swift
//  GtihubSearch
//
//  Created by Jure Čular on 21/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

import Foundation

fileprivate struct SearchResponse: Decodable {
    let items: [Repository]
}

final class SearchService: SearchServiceInterface {
    weak var delegate: SearchServiceDelegate?
    
    private enum Constants {
        static let _queryURL = URL(string: "https://api.github.com/search/repositories")!
        static let _queryKey = "q"
    }
    
    func searchRepositories(searchQuery query: String) {
        guard var URLcomponents = URLComponents(url: Constants._queryURL, resolvingAgainstBaseURL: false) else {
            return
        }
        
        URLcomponents.queryItems = [
            URLQueryItem(name: Constants._queryKey, value: query)
        ]
        
        guard let url = URLcomponents.url else {
            return
        }
        
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) {  [weak self] data, response, error in
            guard let self = self else { return }
            guard error == nil else {
                self.delegate?.failed(withError: error!)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            guard let data = data else {
                self.delegate?.failed(withError: APIError.serviceUnavailable)
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200 ..< 300) ~= response.statusCode else {
                    var errorsMessage: String
                    do {
                        errorsMessage = try jsonDecoder.decode(ErrorResponse.self, from: data).errorMessage
                    } catch {
                        self.delegate?.failed(withError: APIError.invalidResponse)
                        return;
                    }
                    self.delegate?.failed(withError: APIError.message(errorsMessage))
                    return
            }

            
            var repositories: [Repository]
            do {
                repositories = try jsonDecoder.decode(SearchResponse.self, from: data).items
            } catch {
                self.delegate?.failed(withError: APIError.invalidResponse)
                return;
            }
            self.delegate?.successfullyRetrieved(repositories: repositories, forQuery: query)
        }
        task.resume()
    }
}

fileprivate struct ErrorCause: Decodable {
    let message: String
}

fileprivate struct ErrorResponse: Decodable {
    var errorMessage: String {
        guard let error = _errors.first else {
            return _message
        }
        
        return error.message
    }
    
    private let _errors: [ErrorCause]
    private let _message: String
    
    enum CodingKeys: String, CodingKey {
        case _errors = "errors"
        case _message = "message"
    }
}
