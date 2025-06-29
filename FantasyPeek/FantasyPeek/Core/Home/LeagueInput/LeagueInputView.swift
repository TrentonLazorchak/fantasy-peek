//
//  HomeView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/9/25.
//

import SwiftUI

struct LeagueInputView: View {

    @State var viewModel: LeagueInputViewModel

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 20) {
                    Text("Find Your League Info")
                        .font(.title)

                    TextField("Enter Sleeper League ID", text: $viewModel.leagueID)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button("Load Sleeper League Info") {
                        Task {
                            await viewModel.fetchSleeperLeagueInfo()
                        }
                    }

                    if let leagueInfo = viewModel.leagueInfo {
                        NavigationLink {
                            TabBarView(leagueID: leagueInfo.id)
                        } label: {
                            IndividualLeagueView(leagueName: leagueInfo.name, leagueAvatar: leagueInfo.avatar)
                        }
                    } else if viewModel.viewState == .failure {
                        Text("There was an error loading the sleeper league info.")
                            .foregroundColor(.red)
                            .padding()
                    }

                    Spacer()
                }
                .navigationTitle("League Lookup")
                .padding()

                if viewModel.viewState == .loading {
                    LoadingView()
                }
            }
        }
    }
}

// TODO: Use mock managers for previews
#Preview {
    LeagueInputView(viewModel: .init())
}
