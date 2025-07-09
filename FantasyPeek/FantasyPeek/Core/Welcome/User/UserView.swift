//
//  UserView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/11/25.
//

import SwiftUI

struct UserView: View {

    @State var viewModel: UserViewModel
    @Binding var leagueID: String?

    var body: some View {
        ZStack {
            ScrollView {
                Text("Find Your Leagues")
                    .font(.system(size: 40, weight: .black))
                    .multilineTextAlignment(.center)

                TextField("Enter Sleeper Username", text: $viewModel.username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Text("Select a year")
                    .font(.headline)
                    .padding(.top, 20)

                Picker("Select Year", selection: $viewModel.selectedYear) {
                    ForEach(UserViewModel.selectableYears, id: \.self) { year in
                        Text(year).tag(year)
                    }
                }
                .pickerStyle(.wheel) // .menu or .segmented also available
                .frame(maxHeight: 100)

                Button("Load Sleeper Leagues") {
                    Task {
                        await viewModel.loadSleeperLeaguesWithUID()
                    }
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding(.vertical, 12)

                if let leagues = viewModel.leagues,
                   viewModel.viewState == .loaded {
                    ForEach(leagues, id: \.id) { league in
                        Button {
                            leagueID = league.id
                        } label: {
                            IndividualLeagueView(leagueName: league.name, leagueAvatar: league.avatar)
                        }
                        .buttonStyle(.plain)
                    }
                } else if viewModel.viewState == .empty {
                    Text("No leagues returned")
                        .padding()
                } else if viewModel.viewState == .failure {
                    Text("There was an error loading the sleeper user info.")
                        .foregroundColor(.red)
                        .padding()
                }

                Spacer()
            }
            .scrollBounceBehavior(.basedOnSize)
            .scrollDismissesKeyboard(.immediately)
            .navigationTitle("Leagues for User")
            .padding()

            if viewModel.viewState == .loading {
                LoadingView()
            }
        }
    }

}

#Preview("Success") {
    @Previewable @State var leagueID: String? = "Test"
    UserView(viewModel: .init(manager: MockSleeperManager.sampleSuccess), leagueID: $leagueID)
}

#Preview("Failure") {
    @Previewable @State var leagueID: String? = nil
    UserView(viewModel: .init(manager: MockSleeperManager.sampleFailure), leagueID: $leagueID)
}
