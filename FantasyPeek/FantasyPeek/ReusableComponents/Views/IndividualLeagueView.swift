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
    
    @Environment(\.colorScheme) var colorScheme
    var dynamicColor: Color {
        colorScheme == .dark ? .white : .black
    }

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: leagueAvatar ?? "")) { image in
                image
                    .resizable()
            } placeholder: {
                PlaceholderView()
            }
            .frame(width: 50, height: 50)

            Text("\(leagueName)")
                .font(.headline)
                .foregroundStyle(dynamicColor)
        }
    }
}

#Preview {
    IndividualLeagueView(leagueName: "Test League", leagueAvatar: nil)
}
