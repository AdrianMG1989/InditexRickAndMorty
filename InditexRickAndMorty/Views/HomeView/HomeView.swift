//
//  HomeView.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 28/3/25.
//

import SwiftUI
import RickAndMortySearchBar

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    @State private var searchText = ""
    @State private var selectedStatus: FilterStatus = .all
    @State private var showErrorAlert = false
    
    private let minimumSearchLength = 3
    
    var body: some View {
            ZStack {
                ScrollView {
                    
                    SearchBarView(searchText: $searchText, placeholderText: NSLocalizedString("homeview_searchbar_placeholder", comment: "placeholder text"))
                        .onChange(of: searchText) {
                            delayedSearch()
                        }
                    
                    StatusFilterView(selectedStatus: $selectedStatus)
                        .onChange(of: selectedStatus) {
                            fetchCharacters(isNewSearch:true)
                        }
                    
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.characters, id: \.id) { character in
                            
                            Button {
                                viewModel.characterTapped(character)
                            } label: {
                                CharacterCardView(character: character)
                            }
                            .onAppear {
                                if character == viewModel.characters.last {
                                    fetchCharacters(isNewSearch: false)
                                }
                            }
                        }
                        if viewModel.isLoading {
                            ProgressView()
                                .padding()
                        }
                        if (viewModel.characters.isEmpty && !viewModel.isLoading) {

                            Text(NSLocalizedString("homeview_characters_empty", comment: "characters is empty"))
                                .primaryTextStyle()
                        }
                    }
                }
            }
            .navigationTitle(NSLocalizedString("homeview_characters_title", comment: "characters title"))
            .preferredColorScheme(.dark)
            .alert("Error", isPresented: $showErrorAlert) {
                Button("Ok", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage ?? NSLocalizedString("homeview_unknow_error", comment: "Unknown error message"))
            }
            .onChange(of: viewModel.errorMessage){
                showErrorAlert = viewModel.errorMessage != nil
            }
    }
    
    private func fetchCharacters(isNewSearch:Bool) {
        Task {
            await viewModel.fetchFilteredCharacters(name: searchText, status: selectedStatus.apiValue, isNewSearch: isNewSearch)
        }
    }
    
    private func delayedSearch() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if ((searchText.count >= minimumSearchLength) || searchText.isEmpty) {
                fetchCharacters(isNewSearch:true)
            }
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



