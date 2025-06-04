//
//  CharacterDetailView.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 28/3/25.
//

import SwiftUI
import Kingfisher

struct CharacterDetailView: View {
    
    let character: Character
    
    var body: some View {
        
        ScrollView {
             VStack(alignment: .leading, spacing: 16) {

                 KFImage(URL(string: character.imageUrl))
                     .placeholder {
                         ProgressView()
                     }
                     .resizable()
                     .aspectRatio(contentMode: .fit)
                     .clipShape(RoundedRectangle(cornerRadius: 12))
                     .accessibilityHidden(true)

                 Text(String(format: NSLocalizedString("characterdetailview_status_text", comment: "Character status text"), character.status.rawValue))
                     .secondaryTextStyle()

                 Text(String(format: NSLocalizedString("characterdetailview_species_text", comment: "Character species text"), character.species))
                     .secondaryTextStyle()

                 Text(String(format: NSLocalizedString("characterdetailview_gender_text", comment: "Character gender text"), character.gender))
                     .secondaryTextStyle()

                 Text(String(format: NSLocalizedString("characterdetailview_location_text", comment: "Character location text"), character.location.name))
                     .secondaryTextStyle()

                 Text(String(format: NSLocalizedString("characterdetailview_originlocation_text", comment: "Character origin location text"), character.origin.name))
                     .secondaryTextStyle()
             }
             .padding()
         }
         .navigationTitle(character.name)
    }
}

#Preview {
    CharacterDetailView(character: Character(id:  1, name: "Rick Sanchez", status: .alive, species: "Human", gender: "Male", origin: Location(name: "Earth (C-137"), location: Location(name: "Citadel of Ricks"), imageUrl: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"))
}
