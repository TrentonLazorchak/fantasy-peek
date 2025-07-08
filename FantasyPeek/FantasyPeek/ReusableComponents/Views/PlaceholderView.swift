//
//  PlaceholderView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 7/7/25.
//

import SwiftUI

struct PlaceholderView: View {
    @Environment(\.colorScheme) var colorScheme
    var dynamicColor: Color {
        colorScheme == .dark ? .white : .black
    }
    var reverseDynamicColor: Color {
        colorScheme == .dark ? .black : .white
    }
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(dynamicColor)
            Image(systemName: "american.football.fill")
                .foregroundStyle(reverseDynamicColor)
        }
    }
}

#Preview {
    PlaceholderView()
}
