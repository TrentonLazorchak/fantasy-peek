//
//  UserViewModel.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/11/25.
//

import Observation

@Observable @MainActor
final class UserViewModel {

    let sleeperManager: SleeperManaging
    init(manager: SleeperManaging = SleeperManager()) {
        self.sleeperManager = manager
    }

    var username: String = ""
    var leagues: [LeagueInfoViewModel]?

    var viewState: ViewState = .loaded
    enum ViewState {
        case loading
        case loaded
        case empty
        case failure
    }

    func fetchSleeperLeaguesWithUID() async {
        leagues = nil
        viewState = .loading

        do {
            // TODO: Allow user to select year
            if let sleeperLeagues = try await sleeperManager.fetchAllLeagues(for: username, season: "2024") {
                leagues = sleeperLeagues.map { league in
                        .init(sleeperLeagueInfo: league)
                }
            } else {
                viewState = .empty
            }
            viewState = leagues?.isEmpty != false ? .empty : .loaded
            // TODO: Show list of leagues, on selection, show tab bar view
        } catch {
            viewState = .failure
        }
    }

}
