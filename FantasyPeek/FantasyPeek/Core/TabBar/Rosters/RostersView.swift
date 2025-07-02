//
//  RostersView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/25/25.
//

import SwiftUI

struct RostersView: View {

    @State var viewModel: RostersViewModel

    var body: some View {
        ZStack {
            switch viewModel.viewState {
            case .initial, .loaded, .loading:
                VStack {
                    ScrollableTabPicker(
                        selectedIndex: $viewModel.selectedRosterIndex,
                        didFinishLoading: $viewModel.didFinishLoading,
                        items: viewModel.teams.map { $0.userDisplayName }
                    )

                    // Roster Tabs
                    if viewModel.viewState == .initial {
                        RosterSkeletonView()
                    } else {
                        TabView(selection: $viewModel.selectedRosterIndex) {
                            ForEach(viewModel.teams, id: \.id) { team in
                                RosterView(team: team)
                                    .tag(team.index)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                    }
                }

                if viewModel.viewState == .loading {
                    LoadingView()
                }
            case .empty:
                VStack {
                    Text("No Rosters Found")
                        .font(.title)
                }
            case .failure:
                VStack {
                    Text("An Error Has Occurred")
                        .font(.title)
                    Button("Retry") {
                        Task {
                            await viewModel.fetchRosters()
                        }
                    }
                }
            }
        }
        .onFirstAppear {
            Task {
                await viewModel.fetchRosters()
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                if let teamName = viewModel.selectedTeam?.teamName {
                    Text(teamName)
                } else if let userDisplayName = viewModel.selectedTeam?.teamName {
                    Text("\(userDisplayName)'s Team")
                } else if viewModel.viewState == .initial {
                    Text("TrentonLaz's Team")
                        .redacted(reason: .placeholder)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

}

#Preview {
    NavigationView {
        RostersView(viewModel: .init(leagueID: "1182862660101533696"))
    }
}
