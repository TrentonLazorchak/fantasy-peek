//
//  IfViewModifier.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/30/25.
//

import SwiftUI

/// A view modifier to allow option to only apply if a Bool condition is met
extension View {
    @ViewBuilder
    func `if`<Content: View>(
        _ condition: Bool,
        apply: (Self) -> Content
    ) -> some View {
        if condition {
            apply(self)
        } else {
            self
        }
    }
}
