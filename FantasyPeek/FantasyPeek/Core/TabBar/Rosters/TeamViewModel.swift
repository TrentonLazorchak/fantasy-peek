//
//  TeamViewModel.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 7/2/25.
//

import Foundation

/// A view model used to store the info used by the UI for a team
struct TeamViewModel: Equatable {
    let id: UUID = UUID()
    let userDisplayName: String
    let teamName: String?
    let avatar: String?
    let starters: [PlayerViewModel]
    let bench: [PlayerViewModel]
    let wins: Int
    let losses: Int
    let ties: Int
    let index: Int

    /// A summary of the team information used by FoundationalModels
    var summary: String {
        var lines: [String] = []

        lines.append("Team \(index + 1): \(teamName ?? "Unnamed Team")")
        lines.append("Manager: \(userDisplayName)")
        lines.append("Record: \(wins)-\(losses)-\(ties)")

        if !starters.isEmpty {
            lines.append("Starters:")
            for player in starters {
                lines.append("• \(player.summary)")
            }
        }

        if !starters.isEmpty {
            lines.append("Starters:")
            for player in starters {
                lines.append("• \(player.summary)")
            }
        }

        if !bench.isEmpty {
            lines.append("Bench:")
            for player in bench {
                lines.append("• \(player.summary)")
            }
        }

        return lines.joined(separator: "\n")
    }
}

/// A view model storing the player information
struct PlayerViewModel: Equatable {
    let playerID: String
    let name: String?
    let position: String?
    let team: String?

    /// A summary of the player information used by FoundationalModels
    var summary: String {
        let displayName = name ?? "Unknown"
        let displayPosition = position ?? "-"
        let displayTeam = team ?? "-"
        return "\(displayName) - \(displayPosition) (\(displayTeam))"
    }
}
