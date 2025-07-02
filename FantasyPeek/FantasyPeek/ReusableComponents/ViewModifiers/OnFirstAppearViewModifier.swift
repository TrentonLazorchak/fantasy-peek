//
//  OnFirstAppearViewModifier.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 7/1/25.
//

import Foundation
import SwiftUI

/// This view modifier is used to call an action only on first appear of a view
struct OnFirstAppearViewModifier: ViewModifier {
    @State private var didAppear: Bool = false
    let perform: (() -> Void)?

    func body(content: Content) -> some View {
        content
            .onAppear {
                if !didAppear {
                    perform?()
                    didAppear = true
                }
            }
    }
}

extension View {
    func onFirstAppear(perform: (() -> Void)?) -> some View {
        modifier(OnFirstAppearViewModifier(perform: perform))
    }
}
