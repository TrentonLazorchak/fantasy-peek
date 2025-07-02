//
//  RootView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/30/25.
//

import SwiftUI

struct RootView: View {

    @State var showHomeView: Bool = false
    @AppStorage("leagueID") var leagueID: String?

    var body: some View {
        ZStack {
            // Only create the tab bar view when we want to show it, to call on appear when created
            if leagueID != nil {
                TabBarView(leagueID: $leagueID)
            }
        }
        .onAppear {
            showHomeView = leagueID == nil
        }
        .onChange(of: leagueID) {
            showHomeView = leagueID == nil
        }
        .fullScreenCover(isPresented: $showHomeView, content: {
            // If the state variable is true (league is not selected), show the home view
            NavigationStack {
                HomeView(leagueID: $leagueID)
            }
        })
    }
}

#Preview {
    RootView()
}
