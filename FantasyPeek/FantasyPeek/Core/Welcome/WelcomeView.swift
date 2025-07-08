//
//  WelcomeView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/13/25.
//

import SwiftUI

struct WelcomeView: View {

    @Binding var leagueID: String?

    var body: some View {
        VStack {
            VStack(spacing: 24) {
                Text("Welcome to FantasyPeek!")
                    .font(.system(size: 40, weight: .black))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)
                
                Text("Take a peek at your fantasy football league, and have fun with some AI features!")
                    .font(.title2).bold()
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                
                Text("Currently only supports Sleeper leagues.")
                    .font(.footnote)
                
                VStack(spacing: 16) {
                    NavigationLink("Enter Username") {
                        UserView(viewModel: .init(), leagueID: $leagueID)
                    }
                    .tint(.purple)

                    NavigationLink("Enter League ID") {
                        LeagueInputView(viewModel: .init(), leagueID: $leagueID)
                    }
                    .tint(.blue)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    NavigationView {
        WelcomeView(leagueID: .constant(nil))
    }
}
