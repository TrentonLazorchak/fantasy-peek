//
//  LeagueView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 7/1/25.
//

import SwiftUI

struct LeagueView: View {

    @State var viewModel: LeagueViewModel

    var body: some View {
        VStack(alignment: .center) {
            // League avatar
            AsyncImage(url: URL(string: viewModel.leagueAvatarURLString ?? "")) { image in
                image
                    .resizable()
            } placeholder: {
                ZStack {
                    Circle()
                        .foregroundStyle(.black)
                    Image(systemName: "american.football.fill")
                        .foregroundStyle(.white)
                        .font(.title)
                }

            }
            .frame(width: 100, height: 100)

            // League name
            Text(viewModel.leagueName)
                .font(.title2)
                .padding(.top, 12)

            // Season
            Text("Season: \(viewModel.season ?? "2025")")

            // Buttons for AI
            VStack(spacing: 8) {
                // TODO: For FoundationalModelsManager, going to pass in the rosters information
                Button("Generate League Name") {

                }
                Button("Rank Teams") {

                }
                Button("Roast League") {
                }

                // TODO: Rate draft
                // TODO: Need to have extra calls in order to get draft information. Probably new tab
            }
            .padding(.top, 24)

            // Teams
            List {
                ForEach(viewModel.teams, id: \.id) { team in
                    HStack {
                        AsyncImage(url: URL(string: team.avatar ?? "")) { image in
                            image
                                .resizable()
                        } placeholder: {
                            ZStack {
                                Circle()
                                    .foregroundStyle(.black)
                                Image(systemName: "american.football.fill")
                                    .foregroundStyle(.white)
                            }

                        }
                        .frame(width: 25, height: 25)

                        if let teamName = team.teamName {
                            Text(teamName)
                        } else {
                            Text("\(team.userDisplayName)'s Team")
                        }

                        Spacer()

                        Text("\(team.wins)-\(team.losses)-\(team.ties)")
                    }
                }
            }
        }
        .onFirstAppear {
            Task {
                await viewModel.fetchLeagueInfo()
            }
        }
    }

}

#Preview {
    LeagueView(viewModel: .init(leagueID: "1182862660101533696"))
}
