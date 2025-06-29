//
//  SleeperPlayersResponse.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/29/25.
//

typealias SleeperPlayersResponse = [String: SleeperPlayer]

struct SleeperPlayer: Codable, Identifiable {
    let id: String
    let firstName: String?
    let lastName: String?
    let fullName: String?
    let position: String?
    let team: String?
    let status: String?
    let age: Int?
    let yearsExp: Int?
    let college: String?
    let injuryStatus: String?
    let newsUpdated: String?

    enum CodingKeys: String, CodingKey {
        case id = "player_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case fullName = "full_name"
        case position
        case team
        case status
        case age
        case yearsExp = "years_exp"
        case college
        case injuryStatus = "injury_status"
        case newsUpdated = "news_updated"
    }
}
