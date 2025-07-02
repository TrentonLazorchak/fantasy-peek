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
                ZStack {
                    Circle()
                        .foregroundStyle(.black)
                    Image(systemName: "american.football.fill")
                        .foregroundStyle(.white)
                }

            }
            .frame(width: 50, height: 50)

            Text("\(leagueName)")
                .font(.headline)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    IndividualLeagueView(leagueName: "Test League", leagueAvatar: nil)
}
