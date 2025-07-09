//
//  TeamViewModelTests.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 7/9/25.
//

import Testing
@testable import FantasyPeek

/// Unit tests for the roster view model
@MainActor
@Suite("TeamViewModelTests")
struct TeamViewModelTests {

    @Test("Team view model summary")
    func testSummary() async {
        let team = TeamViewModel(
            userDisplayName: "UserDisplayName",
            teamName: "TeamName",
            avatar: "Avatar",
            starters: [.init(
                playerID: "PlayerID",
                name: "Name",
                position: "QB",
                team: "WAS"
            )],
            bench: [.init(
                playerID: "BenchPlayerID",
                name: "BenchName",
                position: "RB",
                team: "BAL"
            )],
            wins: 0,
            losses: 0,
            ties: 0,
            index: 0
        )

        // swiftlint:disable:next line_length
        #expect(team.summary == "Team 1: TeamName\nManager: UserDisplayName\nRecord: 0-0-0\nStarters:\n• Name - QB (WAS)\nStarters:\n• Name - QB (WAS)\nBench:\n• BenchName - RB (BAL)")
    }

}
