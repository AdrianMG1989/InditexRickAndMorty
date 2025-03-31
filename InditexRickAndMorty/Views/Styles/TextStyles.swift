//
//  TextStyles.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 30/3/25.
//

import SwiftUI

struct PrimaryTextStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.primary)
    }
}

struct SecondaryTextStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundColor(.secondary)
    }
}

extension View {
    func primaryTextStyle() -> some View {
        self.modifier(PrimaryTextStyle())
    }
    func secondaryTextStyle() -> some View {
        self.modifier(SecondaryTextStyle())
    }
}
