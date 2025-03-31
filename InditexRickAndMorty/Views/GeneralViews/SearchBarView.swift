//
//  SearchBarView.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 30/3/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var placeholderText: String
    
    var body: some View {

        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.primary)
                .accessibilityHidden(true)
            
            TextField(placeholderText, text: $searchText)
                .textFieldStyle(PlainTextFieldStyle())
                .autocapitalization(.none)
                .foregroundColor(.primary.opacity(0.8))
                .tint(.primary)
                .accessibilityLabel(placeholderText)
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.primary)
                        .accessibilityHidden(true)
                }
                .accessibilityLabel(NSLocalizedString("searchbarview_accessibility_delete_button_label", comment: "accesibility label"))
                .accessibilityHint(NSLocalizedString("searchbarview_accessibility_delete_button_hint", comment: "accesibility hint"))
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground).opacity(0.4))
        .cornerRadius(12)
        .padding([.top,.horizontal])
    }
}
