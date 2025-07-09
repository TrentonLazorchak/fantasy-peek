//
//  SleeperRosterModel.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/25/25.
//

/// A model for roster information retrieved from Sleeper
struct SleeperRosterModel: Codable {
    let id: Int
    let ownerID: String?
    let leagueID: String
    let starters: [String]?
    let players: [String]?
    let settings: SleeperRosterSettings?
    let metadata: [String: String]?
    let coOwners: [String]?

    enum CodingKeys: String, CodingKey {
        case id = "roster_id"
        case ownerID = "owner_id"
        case leagueID = "league_id"
        case starters
        case players
        case settings
        case metadata
        case coOwners = "co_owners"
    }
}

/// A model for roster settings information retrieved from Sleeper
struct SleeperRosterSettings: Codable {
    let wins: Int?
    let losses: Int?
    let ties: Int?

    enum CodingKeys: String, CodingKey {
        case wins
        case losses
        case ties
    }
}
