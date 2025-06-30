//
//  TabBarView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/24/25.
//

import SwiftUI

struct TabBarView: View {

    let leagueID: String

    var body: some View {
        TabView {
            Tab("Roster", systemImage: "person.3.fill") {
                NavigationStack {
                    RostersView(viewModel: .init(leagueID: leagueID))
                }
            }

            Tab("League", systemImage: "trophy") {
                NavigationStack {
                    Text("League View")
                }
            }

            Tab("Settings", systemImage: "gear") {
                NavigationStack {
                    Text("Settings View")
                }
            }
        }
    }

}

#Preview {
    TabBarView(leagueID: "1182862660101533696")
}
