//
//  TabBarView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/24/25.
//

import SwiftUI

/// A tab view that holds the views for a user with a selected league id
struct TabBarView: View {

    @Binding var leagueID: String?

    var body: some View {
        TabView {
            Tab("Roster", systemImage: "person.3.fill") {
                NavigationStack {
                    RostersView(viewModel: .init(leagueID: leagueID))
                }
            }

            Tab("League", systemImage: "trophy") {
                NavigationStack {
                    LeagueView(viewModel: .init(leagueID: leagueID))
                }
            }

            Tab("Settings", systemImage: "gear") {
                NavigationStack {
                    SettingsView(leagueID: $leagueID)
                }
            }
        }
    }

}

#Preview {
    TabBarView(leagueID: .constant("1182862660101533696"))
}
