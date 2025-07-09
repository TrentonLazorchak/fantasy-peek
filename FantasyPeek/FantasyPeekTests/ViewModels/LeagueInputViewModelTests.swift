//
//  LeagueInputViewModelTests.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 7/9/25.
//

import Testing
@testable import FantasyPeek

/// Unit tests for the league input view model
@MainActor
@Suite("LeagueInputViewModelTests")
struct LeagueInputViewModelTests {

    @Test("Load Sleeper League Info - success scenario")
    func loadSleeperLeagueInfoSuccess() async {
        let viewModel = LeagueInputViewModel(manager: MockSleeperManager.sampleSuccess)

        #expect(viewModel.viewState == .loaded)

        await viewModel.loadSleeperLeagueInfo()

        #expect(viewModel.viewState == .loaded)

        let expectedLeagueInfo = LeagueInfoViewModel(
            id: "LeagueID",
            name: "Name",
            avatar: "https://sleepercdn.com/avatars/thumbs/Avatar"
        )
        #expect(viewModel.leagueInfo == expectedLeagueInfo)
    }

    @Test("Load Sleeper League Info - failure scenario")
    func loadSleeperLeagueInfoFailure() async {
        let viewModel = LeagueInputViewModel(manager: MockSleeperManager.sampleFailure)

        #expect(viewModel.viewState == .loaded)

        await viewModel.loadSleeperLeagueInfo()

        #expect(viewModel.viewState == .failure)
    }

}
