//
//  Repository.swift
//  GtihubSearch
//
//  Created by Jure Čular on 21/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

import Foundation

struct Repository: Decodable {
    let name: String
    let owner: Owner
    let description: String?
    
    init(name: String, owner: Owner, description: String?, lastUpdateTime: String) {
        self.name = name
        self.owner = owner
        self.description = description
        self._lastUpdateTime = lastUpdateTime
    }
    
    var lastUpdateTime: Date? {
        get {
            return Date.isoDate(fromString: _lastUpdateTime)
        }
    }
    
    private let _lastUpdateTime: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case owner
        case description
        case _lastUpdateTime = "updated_at"
    }
}
