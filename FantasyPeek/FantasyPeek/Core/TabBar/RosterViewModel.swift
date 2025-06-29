//
//  RosterViewModel.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/25/25.
//

import Observation

struct TeamViewModel {
    let id: Int
    let userDisplayName: String
    let starterNames: [String]
    let playerName: [String]
    let wins: Int
    let losses: Int
    let ties: Int
}

@Observable @MainActor
final class RosterViewModel {

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

    func fetchRosters(isRefresh: Bool) async {
        viewState = isRefresh ? .loading : .initial

        do {
            // Call to fetch rosters
            let rosters = try await sleeperManager.fetchAllRosters(leagueID: leagueID)
            for roster in rosters {
                // Fetch username from owner id
                var username = "Username"
                if let ownerID = roster.ownerID {
                    username = try await sleeperManager.fetchDisplayName(userID: ownerID)
                }

                // Then, call to fetch players (NEED TO CACHE FOR 24 HOURS)
                
            }

//            for roster in rosters {
                // TODO: Store roster data,
                // TODO: Fetch username from owner id
                // TODO: Then, call to fetch players (NEED TO CACHE FOR 24 HOURS)
                // TODO: Then, map the roster starter ids to players and store their names
                // TODO: Then, do the same for the players array
                // TODO: Then map wins, losses, and ties (default to 0)
//            }
            // TODO: Display the above in a tab view or something that user can swipe through
        } catch {
            viewState = .failure
        }
    }

    // TODO: Separate function one will be to generate a team name using foundational models

}
