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
        NavigationStack {
            VStack {
                Text("Welcome to FantasyPeek!")
                    .font(.largeTitle)
                
                HStack {
                    NavigationLink("Enter League ID") {
                        LeagueInputView(viewModel: .init(), leagueID: $leagueID)
                    }
                    
                    NavigationLink("Enter Username") {
                        UserView(viewModel: .init(), leagueID: $leagueID)
                    }
                }
            }
        }
    }
}

#Preview {
    WelcomeView(leagueID: .constant(nil))
}
