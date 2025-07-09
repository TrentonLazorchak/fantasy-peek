//
//  RosterViewModelTests.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 7/9/25.
//

import Testing
@testable import FantasyPeek

/// Unit tests for the roster view model
@MainActor
@Suite("RosterViewModelTests")
struct RosterViewModelTests {

    static private let exampleTeam: TeamViewModel = .init(
        userDisplayName: "",
        teamName: nil,
        avatar: nil,
        starters: [],
        bench: [],
        wins: 0,
        losses: 0,
        ties: 0,
        index: 0
    )

    @Test("Generate team name - success scenario")
    func generateTeamNameSuccess() async {
        let viewModel = RosterViewModel(
            team: Self.exampleTeam,
            refreshAction: { _ in },
            foundationModelsManager: MockFoundationModelsManager.sampleSuccess
        )

        #expect(viewModel.generatedTeamName == nil)

        await viewModel.generateTeamName()

        #expect(viewModel.generatedTeamName == "Example Response")
    }

    @Test("Load rosters - failure scenario")
    func generateTeamNameFailure() async {
        let viewModel = RosterViewModel(
            team: Self.exampleTeam,
            refreshAction: { _ in },
            foundationModelsManager: MockFoundationModelsManager.sampleFailure
        )

        await viewModel.generateTeamName()

        #expect(viewModel.generatedTeamName == nil)
        #expect(viewModel.aiError == FoundationModelsError.appleIntelligenceNotEnabled.localizedDescription)
    }

}
