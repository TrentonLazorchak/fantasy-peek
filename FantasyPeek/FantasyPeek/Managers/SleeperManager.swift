//
//  SleeperManager.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/9/25.
//

import Foundation

protocol SleeperManaging {
    func fetchAllLeagues(for username: String, sport: String, season: String) async throws -> [SleeperLeagueInfoModel]?
    func fetchLeagueInfo(leagueID: String) async throws -> SleeperLeagueInfoModel
}

extension SleeperManaging {
    // Provides default values for sport and season. Only "nfl" is available for sport at the moment
    func fetchAllLeagues(for username: String, sport: String = "nfl", season: String) async throws -> [SleeperLeagueInfoModel]? {
        try await fetchAllLeagues(for: username, sport: sport, season: season)
    }
}

final class SleeperManager: SleeperManaging {
    // NOTE: Only support "nfl" for sport right now
    func fetchAllLeagues(for username: String, sport: String, season: String) async throws -> [SleeperLeagueInfoModel]? {
        // Call to get user ID from the passed in username
        guard let userURL = URL(string: "https://api.sleeper.app/v1/user/\(username)") else {
            assertionFailure("Invalid user URL")
            throw URLError(.badURL)
        }
        let (userData, _) = try await URLSession.shared.data(from: userURL)
        let userID = try JSONDecoder().decode(SleeperUser.self, from: userData).userID

        guard let url = URL(string: "https://api.sleeper.app/v1/user/\(userID)/leagues/\(sport)/\(season)") else {
            assertionFailure("Invalid leagues URL")
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([SleeperLeagueInfoModel]?.self, from: data)
    }

    func fetchLeagueInfo(leagueID: String) async throws -> SleeperLeagueInfoModel {
        guard let url = URL(string: "https://api.sleeper.app/v1/league/\(leagueID)") else {
            assertionFailure("Invalid URL")
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(SleeperLeagueInfoModel.self, from: data)
    }
}
