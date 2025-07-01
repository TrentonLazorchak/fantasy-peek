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
            case .initial, .loaded:
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
        .task {
            await viewModel.fetchRosters()
        }
    }

}

#Preview {
    NavigationView {
        RostersView(viewModel: .init(leagueID: "1182862660101533696"))
    }
}
