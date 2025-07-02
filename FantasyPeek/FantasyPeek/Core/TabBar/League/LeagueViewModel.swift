//
//  LeagueViewModel.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 7/1/25.
//

import Foundation

@Observable @MainActor
final class LeagueViewModel {

    let sleeperManager: SleeperManaging
    let leagueID: String?

    init(manager: SleeperManaging = SleeperManager(), leagueID: String?) {
        self.sleeperManager = manager
        self.leagueID = leagueID
    }

    var leagueAvatarURLString: String?
    var leagueName: String = ""
    var season: String?
    var teams: [TeamViewModel] = []

    var viewState: ViewState = .initial
    enum ViewState {
        case initial
        case loading
        case loaded
        case failure
    }

    func fetchLeagueInfo(isRefresh: Bool = false) async {
        viewState = isRefresh ? .loading : .initial

        do {
            guard let leagueID else {
                viewState = .failure
                return
            }
            let leagueInfo = try await sleeperManager.fetchLeagueInfo(leagueID: leagueID, useCache: !isRefresh)
            leagueAvatarURLString = leagueInfo.avatar
            leagueName = leagueInfo.name
            season = leagueInfo.season

            teams = try await RostersViewModel.getTeams(sleeperManager: sleeperManager, leagueID: leagueID, useCache: !isRefresh)

            viewState = .loaded
        } catch {
            print("Error: \(error.localizedDescription)")
            viewState = .failure
        }
    }

}
