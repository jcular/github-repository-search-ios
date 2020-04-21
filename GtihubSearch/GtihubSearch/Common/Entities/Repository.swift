//
//  Repository.swift
//  GtihubSearch
//
//  Created by Jure Čular on 21/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

import Foundation

struct Repository: Decodable {
    let id: UInt64
    let name: String
    let owner: Owner
    let description: String
    
    var lastUpdateTime: Date? {
        get {
            return Date.isoDate(fromString: _lastUpdateTime)
        }
    }
    
    private let _lastUpdateTime: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case description
        case _lastUpdateTime = "updated_at"
    }
}
