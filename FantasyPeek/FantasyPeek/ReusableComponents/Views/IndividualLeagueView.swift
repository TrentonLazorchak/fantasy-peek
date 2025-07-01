//
//  IndividualLeagueView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/25/25.
//

import SwiftUI

struct IndividualLeagueView: View {

    let leagueName: String
    let leagueAvatar: String?

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: leagueAvatar ?? "")) { image in
                image
                    .resizable()
            } placeholder: {
                // TODO: Probably just like the sleeper logo
                Circle()
            }
            .frame(width: 50, height: 50)

            Text("\(leagueName)")
                .font(.headline)
        }
    }
}

#Preview {
    IndividualLeagueView(leagueName: "Test League", leagueAvatar: nil)
}
