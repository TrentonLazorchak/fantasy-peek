//
//  LeagueInputViewModel.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/9/25.
//

import Observation

/// The view model for the league input view
@Observable @MainActor
final class LeagueInputViewModel {

    let sleeperManager: SleeperManaging
    init(manager: SleeperManaging = SleeperManager()) {
        self.sleeperManager = manager
    }

    var leagueID: String = ""
    var leagueInfo: LeagueInfoViewModel?

    var viewState: ViewState = .loaded
    enum ViewState {
        case loading
        case loaded
        case failure
    }

    /// Loads the league information for the current league id from Sleeper
    func loadSleeperLeagueInfo() async {
        leagueInfo = nil
        viewState = .loading

        do {
            let sleeperLeagueInfo = try await sleeperManager.fetchLeagueInfo(leagueID: leagueID, useCache: false)
            leagueInfo = .init(sleeperLeagueInfo: sleeperLeagueInfo)
            viewState = .loaded
        } catch {
            viewState = .failure
        }
    }

}
