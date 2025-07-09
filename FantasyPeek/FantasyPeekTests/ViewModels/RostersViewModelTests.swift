//
//  RostersViewModelTests.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 7/9/25.
//

import Testing
@testable import FantasyPeek

/// Unit tests for the rosters view model
@MainActor
@Suite("RostersViewModelTests")
struct RostersViewModelTests {

    @Test("Load rosters - success scenario")
    func loadRostersSuccess() async {
        let viewModel = RostersViewModel(sleeperManager: MockSleeperManager.sampleSuccess, leagueID: "123")

        #expect(viewModel.viewState == .initial)

        await viewModel.loadRosters(isRefresh: false)

        #expect(viewModel.viewState == .loaded)
        
        #expect(viewModel.teams.count == 1)

        let team = viewModel.teams[0]
        #expect(team.userDisplayName == "DisplayName")
        #expect(team.teamName == "TeamName")
        #expect(team.avatar == "https://sleepercdn.com/avatars/thumbs/Avatar")
        #expect(team.starters.count == 1)
        #expect(team.bench.count == 1)
        let starter = team.starters[0]
        let bench = team.bench[0]
        let expectedStarter: PlayerViewModel = .init(playerID: "PlayerID", name: "FullName", position: "QB", team: "WAS")
        let expectedBench: PlayerViewModel = .init(playerID: "BenchPlayerID", name: "BenchFullName", position: "RB", team: "BAL")
        #expect(starter == expectedStarter)
        #expect(bench == expectedBench)
    }

    @Test("Load rosters - failure scenario")
    func loadRostersFailure() async {
        let viewModel = RostersViewModel(sleeperManager: MockSleeperManager.sampleFailure, leagueID: "123")

        #expect(viewModel.viewState == .initial)

        await viewModel.loadRosters(isRefresh: false)

        #expect(viewModel.viewState == .failure)
    }

}
