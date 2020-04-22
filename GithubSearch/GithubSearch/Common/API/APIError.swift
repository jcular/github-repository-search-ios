//
//  APIError.swift
//  GtihubSearch
//
//  Created by Jure Čular on 21/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case serviceUnavailable
    case message(String)
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .message(let string):
            return string
        case .serviceUnavailable:
            return NSLocalizedString("serviceUnavailableErrorMessage", comment: "")
        case .invalidResponse:
            return NSLocalizedString("responseInvalid", comment: "")
        }
    }
}
