//
//  RootView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/30/25.
//

import SwiftUI

/// The root view and holds showing welcome view or displaying tab bar view
struct RootView: View {

    @State var showWelcomeView: Bool = false
    @AppStorage("leagueID") var leagueID: String?

    var body: some View {
        ZStack {
            // Only create the tab bar view when we want to show it, to call on appear when created
            if leagueID != nil {
                TabBarView(leagueID: $leagueID)
            }
        }
        .onAppear {
            showWelcomeView = leagueID == nil
        }
        .onChange(of: leagueID) {
            showWelcomeView = leagueID == nil
        }
        .fullScreenCover(isPresented: $showWelcomeView, content: {
            // If the state variable is true (league is not selected), show the home view
            NavigationStack {
                WelcomeView(leagueID: $leagueID)
            }
        })
    }
}

#Preview {
    RootView()
}
