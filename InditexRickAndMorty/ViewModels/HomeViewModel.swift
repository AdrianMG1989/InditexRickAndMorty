//
//  HomeViewModel.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 28/3/25.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    var fetchCharactersUseCase: FetchCharactersUseCaseProtocol
    
    var currentPage = 1
    var totalPages = 1
    
   init(fetchCharactersUseCase: FetchCharactersUseCaseProtocol = FetchCharactersUseCase()) {
       self.fetchCharactersUseCase = fetchCharactersUseCase
        Task {
            await fetchFilteredCharacters(isNewSearch: true)
        }
    }
    
    func resetSearch(){
        currentPage = 1
        totalPages = 1
        characters.removeAll()
    }
    
    func fetchFilteredCharacters(name: String? = nil, status: String? = nil, isNewSearch: Bool) async {
        
        isLoading = true
        errorMessage = nil
        
        defer {
            isLoading = false
        }
        
        if isNewSearch {
            resetSearch()
        }
        
        guard (currentPage <= totalPages) else {
            return
        }
        
        do {
            let fetchedCharacters = try await fetchCharactersUseCase.fetchCharactersWith(page: currentPage, name: name, status: status)
            characters += fetchedCharacters.results
            totalPages = fetchedCharacters.info.pages
        } catch CharacterServiceError.noCharactersFound {
            resetSearch()
            return
        } catch {
            resetSearch()
            errorMessage = "Error loading characters: \(error.localizedDescription)"
            return
        }
        
        currentPage += 1
    }
}
