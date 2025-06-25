//
//  UserView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/11/25.
//

import SwiftUI

struct UserView: View {

    @State var viewModel: UserViewModel

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 20) {
                    Text("Find Your Leagues")
                        .font(.title)

                    TextField("Enter Sleeper Username", text: $viewModel.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Text("Selected Year: \(viewModel.selectedYear)")
                        .font(.headline)

                    Picker("Select Year", selection: $viewModel.selectedYear) {
                        ForEach(UserViewModel.selectableYears, id: \.self) { year in
                            Text(year).tag(year)
                        }
                    }
                    .pickerStyle(.wheel) // .menu or .segmented also available
                    .frame(maxHeight: 150)

                    Button("Load Sleeper Leagues") {
                        Task {
                            await viewModel.fetchSleeperLeaguesWithUID()
                        }
                    }

                    if let leagues = viewModel.leagues,
                       viewModel.viewState == .loaded {
                        List {
                            ForEach(leagues, id: \.id) { league in
                                // TODO: Nav link to tab bar view
                                VStack(spacing: 10) {
                                    Text("Sleeper League Name: \(league.name)")
                                    Text("# of Teams: \(league.totalRosters)")
                                }
                                .padding()
                            }
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
                .navigationTitle("Leagues for User")
                .padding()

                if viewModel.viewState == .loading {
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundStyle(.black.opacity(0.3))
                    ProgressView()
                }
            }
        }
    }

}

#Preview {
    UserView(viewModel: .init())
}
