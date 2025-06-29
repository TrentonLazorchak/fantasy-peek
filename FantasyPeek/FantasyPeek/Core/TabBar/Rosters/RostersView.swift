//
//  RostersView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/25/25.
//

import SwiftUI

struct RostersView: View {

    @State var viewModel: RostersViewModel

    @State private var isButtonDisabled = false

    var body: some View {
        ZStack {
            // Roster Tabs
            TabView(selection: $viewModel.selectedRosterIndex) {
                ForEach(viewModel.teams, id: \.id) { team in
                    RosterView(team: team)
                        .tag(team.index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            // Left Arrow Button
            if viewModel.selectedRosterIndex > 0 {
                Button {
                    withAnimation {
                        viewModel.selectedRosterIndex -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .padding()
                        .clipShape(Circle())
//                        .foregroundStyle(CrownItColors.purple.color)
                }
                .position(x: 30, y: 215)
                .disabled(isButtonDisabled)
            }

            // Right Arrow Button
            if viewModel.selectedRosterIndex < viewModel.teams.count - 1 {
                Button {
                    withAnimation {
                        viewModel.selectedRosterIndex += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .padding()
                        .clipShape(Circle())
//                        .foregroundStyle(CrownItColors.purple.color)
                }
                .position(x: UIScreen.main.bounds.width - 30, y: 215)
                .disabled(isButtonDisabled)
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
