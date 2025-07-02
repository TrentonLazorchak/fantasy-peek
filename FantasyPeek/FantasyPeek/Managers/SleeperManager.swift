//
//  SleeperManager.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/9/25.
//

import Foundation

protocol SleeperManaging {
    func fetchAllLeagues(username: String, sport: String, season: String) async throws -> [SleeperLeagueInfoModel]?
    func fetchLeagueInfo(leagueID: String, useCache: Bool) async throws -> SleeperLeagueInfoModel
    func fetchAllRosters(leagueID: String, useCache: Bool) async throws -> [SleeperRosterModel]
    func fetchAllUsers(leagueID: String, useCache: Bool) async throws -> [SleeperUserModel]
    func fetchAllNFLPlayers() async throws -> SleeperPlayersResponse
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
    
    // User is user id or username
    private func fetchUser(user: String) async throws -> SleeperUserModel {
        try await fetch(urlString: "\(Self.baseURL)/user/\(user)", as: SleeperUserModel.self)
    }

    func fetchLeagueInfo(leagueID: String, useCache: Bool) async throws -> SleeperLeagueInfoModel {
        try await fetch(urlString: "\(Self.baseURL)/league/\(leagueID)", as: SleeperLeagueInfoModel.self, useCache: useCache)
    }

    func fetchAllRosters(leagueID: String, useCache: Bool) async throws -> [SleeperRosterModel] {
        try await fetch(urlString: "\(Self.baseURL)/league/\(leagueID)/rosters", as: [SleeperRosterModel].self, useCache: useCache)
    }

    func fetchAllUsers(leagueID: String, useCache: Bool) async throws -> [SleeperUserModel] {
        try await fetch(urlString: "\(Self.baseURL)/league/\(leagueID)/users", as: [SleeperUserModel].self, useCache: useCache)
    }

    func fetchAllNFLPlayers() async throws -> SleeperPlayersResponse {
        try await fetch(urlString: "\(Self.baseURL)/players/nfl", as: SleeperPlayersResponse.self, useCache: true)
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
}
