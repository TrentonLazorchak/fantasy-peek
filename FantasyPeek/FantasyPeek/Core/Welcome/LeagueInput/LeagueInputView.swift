//
//  LeagueInputView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/9/25.
//

import SwiftUI

struct LeagueInputView: View {

    @State var viewModel: LeagueInputViewModel
    @Binding var leagueID: String?

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Find Your League Info")
                        .font(.system(size: 40, weight: .black))
                        .multilineTextAlignment(.center)
                    
                    TextField("Enter Sleeper League ID", text: $viewModel.leagueID)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button("Load Sleeper League Info") {
                        Task {
                            await viewModel.loadSleeperLeagueInfo()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .padding(.bottom, 24)
                    
                    if let leagueInfo = viewModel.leagueInfo {
                        Button {
                            leagueID = leagueInfo.id
                        } label: {
                            IndividualLeagueView(leagueName: leagueInfo.name, leagueAvatar: leagueInfo.avatar)
                        }
                        .buttonStyle(.plain)
                    } else if viewModel.viewState == .failure {
                        Text("There was an error loading the sleeper league info.")
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    Spacer()
                }
                .navigationTitle("League Lookup")
                .padding()
            }
            .scrollBounceBehavior(.basedOnSize)

            if viewModel.viewState == .loading {
                LoadingView()
            }
        }
    }
}

#Preview("Success") {
    @Previewable @State var leagueID: String? = nil
    LeagueInputView(viewModel: .init(manager: MockSleeperManager.sampleSuccess), leagueID: $leagueID)
}

#Preview("Failure") {
    @Previewable @State var leagueID: String? = nil
    LeagueInputView(viewModel: .init(manager: MockSleeperManager.sampleFailure), leagueID: $leagueID)
}
