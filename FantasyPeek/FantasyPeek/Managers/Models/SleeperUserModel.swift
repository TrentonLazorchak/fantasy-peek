//
//  SleeperUserModel.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/22/25.
//

struct SleeperUserModel: Codable {
    let userID: String
    let displayName: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case displayName = "display_name"
    }
}
