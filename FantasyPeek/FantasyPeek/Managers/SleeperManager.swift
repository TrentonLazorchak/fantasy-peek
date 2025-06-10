//
//  SleeperManager.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/9/25.
//

import Foundation

protocol SleeperManaging {
    func fetchLeagueInfo(leagueID: String) async throws -> SleeperLeagueInfoModel
}

final class SleeperManager: SleeperManaging {
    func fetchLeagueInfo(leagueID: String) async throws -> SleeperLeagueInfoModel {
        guard let url = URL(string: "https://api.sleeper.app/v1/league/\(leagueID)") else {
            assertionFailure("Invalid URL")
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(SleeperLeagueInfoModel.self, from: data)
    }
}
