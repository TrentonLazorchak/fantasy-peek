//
//  RosterView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/29/25.
//

import SwiftUI

struct RosterView: View {

    let team: TeamViewModel
    let refreshAction: (Bool) async -> Void

    var body: some View {
        VStack {
            Button("AI Generate a Team Name") {
                // TODO: Foundational Models call to create team name
            }

            // TODO: Generated team name here

            // TODO: Rate my team with a sheet that pops up
            // TODO: AI Rate My Team

            List {
                Section("Starters") {
                    ForEach(team.starters, id: \.name) { player in
                        PlayerView(position: .init(from: player.position), name: player.name, team: .init(from: player.team))
                    }
                }

                Section("Bench") {
                    ForEach(team.bench, id: \.name) { player in
                        PlayerView(position: .init(from: player.position), name: player.name, team: .init(from: player.team))
                    }
                }
            }
            .refreshable {
                Task {
                    await refreshAction(true)
                }
            }
        }
    }

}

struct RosterSkeletonView: View {
    private static let mockPlayer: PlayerViewModel = .init(playerID: "123", name: nil, position: nil, team: nil)

    var body: some View {
        RosterView(team: .init(
            userDisplayName: "TrentonLaz",
            teamName: nil,
            avatar: nil,
            starters: Array(repeating: Self.mockPlayer, count: 9),
            bench: Array(repeating: Self.mockPlayer, count: 5),
            wins: 10,
            losses: 10,
            ties: 10,
            index: 0
        ), refreshAction: { _ in })
        .scrollDisabled(true)
        .redacted(reason: .placeholder)
    }
}

#Preview {
    let player: PlayerViewModel = .init(playerID: "1234", name: "Trenton Lazorchak", position: "QB", team: "WAS")
    NavigationView {
        RosterView(team: .init(
            userDisplayName: "TrentonLaz",
            teamName: nil,
            avatar: nil,
            starters: Array(repeating: player, count: 8),
            bench: Array(repeating: player, count: 12),
            wins: 12,
            losses: 2,
            ties: 3,
            index: 0
        ), refreshAction: { _ in })
    }
}

#Preview("Skeleton View") {
    NavigationView {
        RosterSkeletonView()
    }
}
