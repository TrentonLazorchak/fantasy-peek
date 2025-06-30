//
//  RosterView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/29/25.
//

import SwiftUI

struct RosterView: View {

    let team: TeamViewModel

    var body: some View {
        VStack {
            Button("Have AI Generate a Team Name") {
                // TODO: Foundational Models call to create team name
            }

            // TODO: Generated team name here

            // TODO: Rate my team

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
        }
        .navigationTitle("\(team.userDisplayName)'s Team")
        .navigationBarTitleDisplayMode(.inline)
    }

}

#Preview {
    let player: PlayerViewModel = .init(playerID: "1234", name: "Trenton Lazorchak", position: "QB", team: "WAS")
    RosterView(team: .init(
        userDisplayName: "TrentonLaz",
        starters: Array(repeating: player, count: 8),
        bench: Array(repeating: player, count: 12),
        wins: 12,
        losses: 2,
        ties: 3,
        index: 0
    ))
}
