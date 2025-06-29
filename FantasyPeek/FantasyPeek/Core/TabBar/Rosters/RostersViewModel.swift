//
//  RosterViewModel.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/25/25.
//

import Observation
import Foundation

struct TeamViewModel {
    let id: UUID = UUID()
    let userDisplayName: String
    let starters: [PlayerViewModel]
    let bench: [PlayerViewModel]
    let wins: Int
    let losses: Int
    let ties: Int
    let index: Int
}

struct PlayerViewModel {
    let name: String?
    let position: String?
    let team: String?
}

@Observable @MainActor
final class RostersViewModel {

    let sleeperManager: SleeperManaging
    let leagueID: String

    init(manager: SleeperManaging = SleeperManager(), leagueID: String) {
        self.sleeperManager = manager
        self.leagueID = leagueID
    }

    var viewState: ViewState = .initial
    enum ViewState {
        case initial
        case loading
        case loaded
        case empty
        case failure
    }

    var teams: [TeamViewModel] = []
    var selectedRosterIndex: Int = 0

    func fetchRosters(isRefresh: Bool) async {
        viewState = isRefresh ? .loading : .initial

        do {
            // Call to fetch rosters
            let rosters = try await sleeperManager.fetchAllRosters(leagueID: leagueID)
            var newTeams: [TeamViewModel] = []

            let nflPlayers = try await sleeperManager.fetchAllNFLPlayers()
            var index = 0
            for roster in rosters {
                // Fetch username from owner id
                var userDisplayName = "Username"
                if let ownerID = roster.ownerID {
                    userDisplayName = try await sleeperManager.fetchDisplayName(userID: ownerID)
                }

                // Then, map the roster starter ids to starters and players and store
                var starters: [PlayerViewModel] = []
                if let rosterStarters = roster.starters {
                    starters = rosterStarters.compactMap { starter in
                        guard let player = nflPlayers[starter] else { return nil }
                        return PlayerViewModel(name: player.fullName, position: player.position, team: player.team)
                    }
                }
                var bench: [PlayerViewModel] = []
                if let players = roster.players {
                    bench = players.compactMap { player in
                        guard let nflPlayer = nflPlayers[player] else { return nil }
                        return PlayerViewModel(name: nflPlayer.fullName, position: nflPlayer.position, team: nflPlayer.team)
                    }
                }

                // Then map wins, losses, and ties (default to 0)
                let wins = roster.settings?.wins ?? 0
                let losses = roster.settings?.losses ?? 0
                let ties = roster.settings?.ties ?? 0

                let team = TeamViewModel(
                    userDisplayName: userDisplayName,
                    starters: starters,
                    bench: bench,
                    wins: wins,
                    losses: losses,
                    ties: ties,
                    index: index
                )
                index += 1
                newTeams.append(team)
            }
            teams = newTeams
            viewState = .loaded
        } catch {
            print("Error: \(error.localizedDescription)")
            viewState = .failure
        }
    }

    // TODO: Separate function one will be to generate a team name using foundational models

}
