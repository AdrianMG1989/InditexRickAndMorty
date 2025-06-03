// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct SearchBarView: View {
    @Binding var searchText: String
    
    let placeholderText: String
    
    public init(searchText: Binding<String>, placeholderText: String) {
        self._searchText = searchText
        self.placeholderText = placeholderText
    }
    
    public var body: some View {

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
                .accessibilityLabel(NSLocalizedString("searchbarview_accessibility_delete_button_label", bundle: .module, comment: "accesibility label"))
                .accessibilityHint(NSLocalizedString("searchbarview_accessibility_delete_button_hint", bundle: .module, comment: "accesibility hint"))
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground).opacity(0.4))
        .cornerRadius(12)
        .padding([.top,.horizontal])
    }
}
