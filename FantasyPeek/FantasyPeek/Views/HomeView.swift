//
//  HomeView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/13/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        // TODO: Tab bar view will show this as a sheet. Then after select league we'll dismiss and load tab bar view
        NavigationStack {
            VStack {
                Text("Welcome to FantasyPeek!")
                    .font(.largeTitle)
                
                HStack {
                    NavigationLink("Enter League ID") {
                        LeagueInputView(viewModel: .init())
                    }
                    
                    NavigationLink("Enter Username") {
                        UserView(viewModel: .init())
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
