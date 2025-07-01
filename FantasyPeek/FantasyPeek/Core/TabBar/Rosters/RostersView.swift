//
//  RostersView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/25/25.
//

import SwiftUI

struct RostersView: View {

    @State var viewModel: RostersViewModel

    // TODO: Switch on view state and add a failure state
    var body: some View {
        ZStack {
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
        }
        .task {
            await viewModel.fetchRosters(isRefresh: false)
        }
    }

}

#Preview {
    NavigationView {
        RostersView(viewModel: .init(leagueID: "1182862660101533696"))
    }
}
