//
//  Message.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

struct Message: Decodable {
    var data: [MessageData]
}

struct MessageData: Decodable {
    
    var username: String
    var avatarUrl: String
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case username = "name"
        case avatarUrl = "avatar_url"
        case message = "message"
    }
}
