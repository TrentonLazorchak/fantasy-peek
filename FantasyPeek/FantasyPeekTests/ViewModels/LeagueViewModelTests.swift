//
//  LeagueViewModelTests.swift
//  FantasyPeekTests
//
//  Created by Trenton Lazorchak on 5/30/25.
//

import Testing
@testable import FantasyPeek

/// Unit tests for the league view model
@MainActor
@Suite("LeagueViewModelTests")
struct LeagueViewModelTests {

    @Test("Load league info - success scenario")
    func loadLeagueInfoSuccess() async {
        let viewModel = LeagueViewModel(sleeperManager: MockSleeperManager.sampleSuccess, leagueID: "123")

        #expect(viewModel.viewState == .initial)

        await viewModel.loadLeagueInfo(isRefresh: false)

        #expect(viewModel.viewState == .loaded)
        
        #expect(viewModel.leagueAvatarURLString == "https://sleepercdn.com/avatars/Avatar")
        #expect(viewModel.leagueName == "Name")
        #expect(viewModel.season == "Season")
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

    @Test("Load league info - failure scenario")
    func loadLeagueInfoFailure() async {
        let viewModel = LeagueViewModel(sleeperManager: MockSleeperManager.sampleFailure, leagueID: "123")

        #expect(viewModel.viewState == .initial)

        await viewModel.loadLeagueInfo(isRefresh: false)

        #expect(viewModel.viewState == .failure)
    }
    
    @Test("Generate league name - success scenario")
    func testGenerateLeagueNameSuccess() async {
        let viewModel = LeagueViewModel(foundationModelsManager: MockFoundationModelsManager.sampleSuccess, leagueID: "123")
        
        #expect(viewModel.generatedLeagueName == nil)
        
        await viewModel.generateLeagueName()
        
        #expect(viewModel.generatedLeagueName == "Example Response")
    }
    
    @Test("Generate league name - failure scenario")
    func testGenerateLeagueNameFailure() async {
        let viewModel = LeagueViewModel(foundationModelsManager: MockFoundationModelsManager.sampleFailure, leagueID: "123")
        
        await viewModel.generateLeagueName()
        
        #expect(viewModel.generatedLeagueName == nil)
        #expect(viewModel.aiError == FoundationModelsError.appleIntelligenceNotEnabled.localizedDescription)
    }

}
