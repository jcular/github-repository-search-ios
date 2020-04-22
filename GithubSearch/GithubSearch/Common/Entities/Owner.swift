//
//  Owner.swift
//  GtihubSearch
//
//  Created by Jure Čular on 21/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

struct Owner: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
    }
}
