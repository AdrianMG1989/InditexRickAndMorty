//
//  CharacterListView.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 4/6/25.
//

import SwiftUI

struct CharacterListView: View {
    let characters: [Character]
    let isLoading: Bool
    let onTap: (Character) -> Void
    let onAppear: (Character) -> Void
    
    var body: some View {
        LazyVStack(spacing: 20) {
            ForEach(characters, id: \.id) { character in
                Button {
                    onTap(character)
                } label: {
                    CharacterCardView(character: character)
                }
                .onAppear {
                    onAppear(character)
                }
            }
            
            if isLoading {
                ProgressView()
                    .padding()
            }
            
            if characters.isEmpty && !isLoading {
                Text(NSLocalizedString("homeview_characters_empty", comment: "characters is empty"))
                    .primaryTextStyle()
            }
        }
    }
}
