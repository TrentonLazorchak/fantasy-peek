//
//  LoadingView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/29/25.
//

import SwiftUI

/// A reusable view for showing a loading state
struct LoadingView: View {
    var body: some View {
        Rectangle()
            .ignoresSafeArea()
            .foregroundStyle(.black.opacity(0.3))
        ProgressView()
    }
}

#Preview {
    LoadingView()
}
