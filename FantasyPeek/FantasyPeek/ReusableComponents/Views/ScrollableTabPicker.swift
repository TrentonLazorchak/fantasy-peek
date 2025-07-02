//
//  ScrollableTabPicker.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/29/25.
//

import SwiftUI

struct ScrollableTabPicker: View {
    @Binding var selectedIndex: Int
    @Binding var didFinishLoading: Bool
    let items: [String]

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    // Show skeleton views if true
                    if !didFinishLoading {
                        ForEach(Array(0...8), id: \.self) { _ in
                            Text("TrentonLaz")
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .cornerRadius(8)
                                .redacted(reason: .placeholder)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 1)
                                )
                        }
                    } else {
                        ForEach(items.indices, id: \.self) { index in
                            Text(items[index])
                                .id(index)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(selectedIndex == index ? Color.blue.opacity(0.2) : Color.clear)
                                .cornerRadius(8)
                                .onTapGesture {
                                    selectedIndex = index
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 1)
                                )
                        }
                    }
                }
                .padding()
            }
            .scrollDisabled(!didFinishLoading)
            .onChange(of: didFinishLoading) {
                if didFinishLoading {
                    Task {
                        // Delay 0.5 seconds (500_000_000 nanoseconds)
                        try? await Task.sleep(nanoseconds: 250_000_000)
                        if let lastIndex = items.indices.last {
                            // Animate scroll to last index on main actor
                            await MainActor.run {
                                withAnimation {
                                    proxy.scrollTo(lastIndex, anchor: .center)
                                }
                            }
                            // Delay another 0.5 seconds
                            try? await Task.sleep(nanoseconds: 500_000_000)
                            // Animate scroll back to start
                            await MainActor.run {
                                withAnimation {
                                    proxy.scrollTo(0, anchor: .center)
                                }
                            }
                        }
                    }
                }
            }
            .onChange(of: selectedIndex) { _, newIndex in
                withAnimation {
                    proxy.scrollTo(newIndex, anchor: .center)
                }
            }
        }
    }
}

#Preview {
    ScrollableTabPicker(selectedIndex: .constant(0), didFinishLoading: .constant(false), items: ["Test", "Trenton", "Testerino", "Meeseeks"])
}
