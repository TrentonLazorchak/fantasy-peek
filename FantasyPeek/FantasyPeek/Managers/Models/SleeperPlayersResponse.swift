//
//  SleeperPlayersResponse.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/29/25.
//

typealias SleeperPlayersResponse = [String: SleeperPlayer]

/// A model for player information retrieved from Sleeper
struct SleeperPlayer: Codable {
    let playerID: String
    let fullName: String?
    let position: String?
    let team: String?

    enum CodingKeys: String, CodingKey {
        case playerID = "player_id"
        case fullName = "full_name"
        case position
        case team
    }
}
