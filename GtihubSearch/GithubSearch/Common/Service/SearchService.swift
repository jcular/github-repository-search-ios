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
            guard let data = data,
                let response = response as? HTTPURLResponse,
                (200 ..< 300) ~= response.statusCode, error == nil else {
                    self.delegate?.failed(withError: APIError.serviceUnavailable)
                    return
            }

            let jsonDecoder = JSONDecoder()
            
            var repositories: [Repository]
            do {
                repositories = try jsonDecoder.decode(SearchResponse.self, from: data).items
            } catch {
                self.delegate?.failed(withError: APIError.invalidResponse)
                return;
            }
            self.delegate?.successfullyRetrieved(repositories: repositories)
        }
        task.resume()
    }
}

