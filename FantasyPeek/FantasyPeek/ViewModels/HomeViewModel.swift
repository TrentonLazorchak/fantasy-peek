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
        id = sleeperLeagueInfo.leagueId
        name = sleeperLeagueInfo.name
        totalRosters = sleeperLeagueInfo.totalRosters
    }
}

@Observable @MainActor
final class HomeViewModel {

    let manager: SleeperManaging
    init(manager: SleeperManaging = SleeperManager()) {
        self.manager = manager
    }

    let leagueID: String = ""
    var leagueInfo: LeagueInfoViewModel?

    var viewState: ViewState = .loaded
    enum ViewState {
        case loading
        case loaded
        case failure
    }

    func fetchSleeperLeagueInfo() async {
        viewState = .loading

        do {
            let sleeperLeagueInfo = try await manager.fetchLeagueInfo(leagueID: leagueID)
            leagueInfo = .init(sleeperLeagueInfo: sleeperLeagueInfo)
            viewState = .loaded
            // TODO: Navigate to tab bar of pages as listed in notes
        } catch {
            viewState = .failure
        }
    }

}
