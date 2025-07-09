//
//  UserViewModelTests.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 7/9/25.
//

import Testing
@testable import FantasyPeek

/// Unit tests for the user view model
@MainActor
@Suite("UserViewModelTests")
struct UserViewModelTests {

    @Test("Load Sleeper Leagues - success scenario")
    func loadSleeperLeaguesSuccess() async {
        let viewModel = UserInputViewModel(manager: MockSleeperManager.sampleSuccess)

        #expect(viewModel.viewState == .loaded)

        await viewModel.loadSleeperLeaguesWithUID()

        #expect(viewModel.viewState == .loaded)

        let expectedLeagues: [LeagueInfoViewModel] = [.init(
            id: "LeagueID", name: "Name", avatar: "https://sleepercdn.com/avatars/thumbs/Avatar"
        )]
        #expect(viewModel.leagues == expectedLeagues)
    }

    @Test("Load Sleeper Leagues - failure scenario")
    func loadSleeperLeaguesFailure() async {
        let viewModel = UserInputViewModel(manager: MockSleeperManager.sampleFailure)

        #expect(viewModel.viewState == .loaded)

        await viewModel.loadSleeperLeaguesWithUID()

        #expect(viewModel.viewState == .failure)
    }

}
