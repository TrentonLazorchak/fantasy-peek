//
//  SleeperUser.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/22/25.
//

struct SleeperUser: Codable {
    let userID: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
}
