//
//  RosterViewModel.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/25/25.
//

import Foundation

@Observable @MainActor
final class RostersViewModel {

    let sleeperManager: SleeperManaging
    let leagueID: String?

    init(manager: SleeperManaging = SleeperManager(), leagueID: String?) {
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

    /// Used for the Tab View to start animation
    var didFinishLoading: Bool = false

    /// The currently selected team
    var selectedTeam: TeamViewModel? {
        guard teams.indices.contains(selectedRosterIndex) else {
            return nil
        }

        return teams[selectedRosterIndex]
    }

    func fetchRosters(isRefresh: Bool = false) async {
        viewState = isRefresh ? .loading : .initial

        do {
            // Call to fetch rosters
            guard let leagueID else {
                viewState = .failure
                return
            }

            teams = try await Self.getTeams(sleeperManager: sleeperManager, leagueID: leagueID, useCache: !isRefresh)
            viewState = .loaded
            didFinishLoading = true
        } catch {
            print("Error: \(error.localizedDescription)")
            viewState = .failure
        }
    }
    
    func updateLoadingState(isLoading: Bool) {
        viewState = isLoading ? .loading : .loaded
    }

    static func getTeams(sleeperManager: SleeperManaging, leagueID: String, useCache: Bool) async throws -> [TeamViewModel] {
        let rosters = try await sleeperManager.fetchAllRosters(leagueID: leagueID, useCache: useCache)
        let nflPlayers = try await sleeperManager.fetchAllNFLPlayers()
        let users = try await sleeperManager.fetchAllUsers(leagueID: leagueID, useCache: useCache)

        var newTeams: [TeamViewModel] = []
        var index = 0
        for roster in rosters {
            let ownerUser = users.first(where: { $0.userID == roster.ownerID })

            // Fetch username from owner id
            var userDisplayName = "Username"
            if let ownerUser {
                userDisplayName = ownerUser.displayName
            }

            // Then, map the roster starter ids to starters and players and store
            var starters: [PlayerViewModel] = []
            if let rosterStarters = roster.starters {
                starters = rosterStarters.compactMap { starter in
                    guard let player = nflPlayers[starter] else { return nil }
                    return PlayerViewModel(playerID: player.playerID, name: player.fullName, position: player.position, team: player.team)
                }
            }
            var bench: [PlayerViewModel] = []
            if let players = roster.players {
                bench = players.compactMap { player in
                    guard let nflPlayer = nflPlayers[player] else { return nil }
                    // Don't include starters to the bench
                    guard !starters.contains(where: { $0.playerID == nflPlayer.playerID }) else { return nil }
                    return PlayerViewModel(playerID: nflPlayer.playerID, name: nflPlayer.fullName, position: nflPlayer.position, team: nflPlayer.team)
                }
            }

            // Then map wins, losses, and ties (default to 0)
            let wins = roster.settings?.wins ?? 0
            let losses = roster.settings?.losses ?? 0
            let ties = roster.settings?.ties ?? 0

            let team = TeamViewModel(
                userDisplayName: userDisplayName,
                teamName: ownerUser?.metadata?.teamName,
                avatar:  "\(SleeperManager.avatarBaseURL)/thumbs/\(ownerUser?.avatar ?? "")",
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

        return newTeams
    }

}
