//
//  HomeViewModel.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/9/25.
//

import Observation

struct LeagueInfoViewModel {
    let id: String
    let name: String
    let totalRosters: Int

    init(sleeperLeagueInfo: SleeperLeagueInfoModel) {
        id = sleeperLeagueInfo.leagueID
        name = sleeperLeagueInfo.name
        totalRosters = sleeperLeagueInfo.totalRosters
    }
}

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

    func fetchSleeperLeagueInfo() async {
        leagueInfo = nil
        viewState = .loading

        do {
            let sleeperLeagueInfo = try await sleeperManager.fetchLeagueInfo(leagueID: leagueID)
            leagueInfo = .init(sleeperLeagueInfo: sleeperLeagueInfo)
            viewState = .loaded
            // TODO: Navigate to tab bar of pages as listed in notes
        } catch {
            viewState = .failure
        }
    }

}
