//
//  AIModalView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 7/8/25.
//

import SwiftUI

struct AIModalView: View {
    
    let title: String
    let bodyText: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text(title)
                    .font(.system(size: 40, weight: .black))
                
                Text(bodyText)
                    .font(.body)
                
                Spacer()
            }
            .padding(.top, 24)
            .padding(.horizontal, 12)
        }
        .scrollBounceBehavior(.basedOnSize)
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    Text("")
        .sheet(isPresented: .constant(true)) {
            AIModalView(title: "Rank My Team", bodyText: "This team looks very good. You have lots of great players and stuff. Very very good stuff.")
        }

}
