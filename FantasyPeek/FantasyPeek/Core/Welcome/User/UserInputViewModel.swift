//
//  UserInputViewModel.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/11/25.
//

import Observation
import Foundation

/// The view model for the User Input view
@Observable @MainActor
final class UserInputViewModel {

    let sleeperManager: SleeperManaging
    init(manager: SleeperManaging = SleeperManager()) {
        self.sleeperManager = manager
    }

    var username: String = ""
    var leagues: [LeagueInfoViewModel]?
    var selectedYear: String = String(Calendar.current.component(.year, from: Date()))

    static let selectableYears: [String] = Array(2018...2025).reversed().map { String($0) }

    var viewState: ViewState = .loaded
    enum ViewState {
        case loading
        case loaded
        case empty
        case failure
    }

    /// Loads leagues from sleeper based on the user id or username
    func loadSleeperLeaguesWithUID() async {
        leagues = nil
        viewState = .loading

        do {
            if let sleeperLeagues = try await sleeperManager.fetchAllLeagues(
                username: username, season: selectedYear, useCache: false
            ) {
                leagues = sleeperLeagues.map { league in
                        .init(sleeperLeagueInfo: league)
                }
            } else {
                viewState = .empty
            }
            viewState = leagues?.isEmpty != false ? .empty : .loaded
        } catch {
            viewState = .failure
        }
    }

}
