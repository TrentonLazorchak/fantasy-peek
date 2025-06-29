//
//  TabBarView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/24/25.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            Tab("Roster", systemImage: "person.3.fill") {
                Text("Roster View")
            }

            Tab("League", systemImage: "trophy") {
                Text("League View")
            }

            Tab("Settings", systemImage: "gear") {
                Text("Settings View")
            }
        }
    }
}

#Preview {
    TabBarView()
}
