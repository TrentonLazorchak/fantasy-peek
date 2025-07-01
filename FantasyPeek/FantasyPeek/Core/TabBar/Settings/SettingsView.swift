//
//  SettingsView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 7/1/25.
//

import SwiftUI

struct SettingsView: View {

    @Binding var leagueID: String?

    var body: some View {
        List {
            Button("Choose Different League") {
                leagueID = nil
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView(leagueID: .constant("asdf"))
}
