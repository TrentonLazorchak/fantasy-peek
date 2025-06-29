//
//  SleeperManager.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/9/25.
//

import Foundation

protocol SleeperManaging {
    func fetchAllLeagues(username: String, sport: String, season: String) async throws -> [SleeperLeagueInfoModel]?
    func fetchLeagueInfo(leagueID: String) async throws -> SleeperLeagueInfoModel
    func fetchAllRosters(leagueID: String) async throws -> [SleeperRosterModel]
    func fetchDisplayName(userID: String) async throws -> String
    func fetchAllNFLPlayers() async throws -> [SleeperPlayersResponse]
}

extension SleeperManaging {
    // Provides default values for sport and season. Only "nfl" is available for sport at the moment
    func fetchAllLeagues(username: String, sport: String = "nfl", season: String) async throws -> [SleeperLeagueInfoModel]? {
        try await fetchAllLeagues(username: username, sport: sport, season: season)
    }
}

final class SleeperManager: SleeperManaging {

    private static let baseURL = "https://api.sleeper.app/v1"

    // NOTE: Only support "nfl" for sport right now
    func fetchAllLeagues(username: String, sport: String, season: String) async throws -> [SleeperLeagueInfoModel]? {
        // Call to get user ID from the passed in username
        let userID = try await fetchUser(user: username).userID

        return try await fetch(urlString: "\(Self.baseURL)/user/\(userID)/leagues/\(sport)/\(season)", as: [SleeperLeagueInfoModel]?.self)
    }

    func fetchLeagueInfo(leagueID: String) async throws -> SleeperLeagueInfoModel {
        try await fetch(urlString: "\(Self.baseURL)/league/\(leagueID)", as: SleeperLeagueInfoModel.self)
    }

    func fetchAllRosters(leagueID: String) async throws -> [SleeperRosterModel] {
        try await fetch(urlString: "\(Self.baseURL)/league/\(leagueID)/rosters", as: [SleeperRosterModel].self)
    }

    func fetchDisplayName(userID: String) async throws -> String {
        try await fetchUser(user: userID).displayName
    }

    func fetchAllNFLPlayers() async throws -> [SleeperPlayersResponse] {
        try await fetch(urlString: "\(Self.baseURL)/players/nfl", as: [SleeperPlayersResponse].self, useCache: true)
    }

    private func fetch<T: Codable>(urlString: String, as type: T.Type, useCache: Bool = false) async throws -> T {
        // Check if cached response exists
        if useCache,
           let cachedData = try await CacheManager.getCachedData(forKey: urlString) {
            let decoded = try JSONDecoder().decode(T.self, from: cachedData)
            return decoded
        }

        guard let url = URL(string: urlString) else {
            assertionFailure("Invalid URL")
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(T.self, from: data)

        // Cache the valid response
        if useCache {
            try await CacheManager.cacheData(decoded, forKey: urlString)
        }

        return decoded
    }

    private func fetchUser(user: String) async throws -> SleeperUserModel {
        guard let userURL = URL(string: "\(Self.baseURL)/user/\(user)") else {
            assertionFailure("Invalid user URL")
            throw URLError(.badURL)
        }
        let (userData, _) = try await URLSession.shared.data(from: userURL)
        return try JSONDecoder().decode(SleeperUserModel.self, from: userData)
    }
}
