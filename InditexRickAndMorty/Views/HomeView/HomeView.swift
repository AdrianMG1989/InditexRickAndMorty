//
//  HomeView.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 28/3/25.
//

import SwiftUI
import RickAndMortySearchBar

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
            
        ScrollView {
            
            SearchBarView(searchText: $viewModel.searchText, placeholderText: NSLocalizedString("homeview_searchbar_placeholder", comment: "placeholder text"))
            
            StatusFilterView(selectedStatus: $viewModel.selectedStatus)
            
            CharacterListView(
                characters: viewModel.characters,
                isLoading: viewModel.isLoading,
                onTap: viewModel.characterTapped,
                onAppear: viewModel.loadMoreIfNeeded
            )
        }
        .navigationTitle(NSLocalizedString("homeview_characters_title", comment: "characters title"))
        .preferredColorScheme(.dark)
        .alert("Error", isPresented: $viewModel.showErrorAlert) {
            Button("Ok", role: .cancel) { viewModel.dismissError() }
        } message: {
            Text(viewModel.errorMessage ?? NSLocalizedString("homeview_unknow_error", comment: "Unknown error message"))
        }
    }
}

private struct StatusFilterView: View {
    @Binding var selectedStatus: FilterStatus

    var body: some View {
        Picker(NSLocalizedString("homeview_pickerstatus_title", comment: "picker title"), selection: $selectedStatus) {
            ForEach(FilterStatus.allCases, id: \.self) { status in
                Text(NSLocalizedString("homeview_pickerstatus_\(status.rawValue)", comment: "picker option")).tag(status)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}
