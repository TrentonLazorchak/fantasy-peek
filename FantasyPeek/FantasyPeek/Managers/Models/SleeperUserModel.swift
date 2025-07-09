//
//  SleeperUserModel.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/22/25.
//

/// A model for user information retrieved from Sleeper
struct SleeperUserModel: Codable {
    let userID: String
    let displayName: String
    let avatar: String
    let metadata: MetaData?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case displayName = "display_name"
        case avatar
        case metadata
    }
}

/// A model for metadata information retrieved from Sleeper
struct MetaData: Codable {
    let teamName: String?

    enum CodingKeys: String, CodingKey {
        case teamName = "team_name"
    }
}
