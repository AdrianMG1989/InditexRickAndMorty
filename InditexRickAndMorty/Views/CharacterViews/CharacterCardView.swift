//
//  CharacterCardView.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 28/3/25.
//

import SwiftUI
import Kingfisher

struct CharacterCardView: View {
    
    let character: Character
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                KFImage(URL(string: character.imageUrl))
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 120, maxHeight: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .accessibilityHidden(true)

                VStack(alignment: .leading) {
                    Text(character.name)
                        .primaryTextStyle()
                    Text(character.status.rawValue)
                        .secondaryTextStyle()
                    Text(character.species)
                        .secondaryTextStyle()
                }
                .padding(.leading, 10)
                Spacer()
            }
            .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemGroupedBackground))
                .shadow(radius: 5)
        )
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .accessibilityElement(children: .combine)
        .accessibilityHint(NSLocalizedString("charactercardview_accessibility_hint", comment: "accesibility hint"))
    }
}

#Preview {
    CharacterCardView(character: Character(id:  1, name: "Rick Sanchez", status: .alive, species: "Human", origin: Location(name: "Earth (C-137"), gender: "Male", location: Location(name: "Citadel of Ricks"), imageUrl: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"))
}
