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
    @Published var searchText: String = ""
    @Published var selectedStatus: FilterStatus = .all
    @Published var errorMessage: String?
    @Published var showErrorAlert = false
    
    private var isFetchingPage = false
    private let fetchCharactersUseCase: FetchCharactersUseCaseProtocol
    private var currentPage = 1
    private var totalPages = 1
    private let minimumSearchLength = 3
    private var debounceTask: Task<Void, Never>?
    
    var onCharacterSelected: ((Character) -> Void)?
    
    init(fetchCharactersUseCase: FetchCharactersUseCaseProtocol) {
        self.fetchCharactersUseCase = fetchCharactersUseCase
        Task {
            await fetchCharacters(isNewSearch: true)
        }
    }

    func characterTapped(_ character: Character) {
        onCharacterSelected?(character)
    }
    
    func updateSearchText(_ newText: String) {
        searchText = newText
        debounceTask?.cancel()
        debounceTask = Task {
            try? await Task.sleep(nanoseconds: 300_000_000)
            if Task.isCancelled { return }
            if searchText.isEmpty || searchText.count >= minimumSearchLength {
                await fetchCharacters(isNewSearch: true)
            }
        }
    }
    
    func updateFilter(_ newStatus: FilterStatus) {
        selectedStatus = newStatus
        Task { await fetchCharacters(isNewSearch: true) }
    }
    
    func loadMoreIfNeeded(currentCharacter: Character) {
        guard currentCharacter == characters.last else { return }
        Task { await fetchCharacters(isNewSearch: false) }
    }
    
    private func resetSearch() {
        currentPage = 1
        totalPages = 1
        characters.removeAll()
    }
    
    private func fetchCharacters(isNewSearch: Bool) async {
        
        guard !isFetchingPage else { return }
        guard currentPage <= totalPages else { return }
        
        if isNewSearch {
            resetSearch()
        }
        
        isLoading = true
        isFetchingPage = true
        errorMessage = nil
        
        defer {
            isLoading = false
            isFetchingPage = false
        }
        
        do {
            let result = try await fetchCharactersUseCase.fetchCharactersWith(
                page: currentPage,
                name: searchText.isEmpty ? nil : searchText,
                status: selectedStatus.apiValue
            )
            characters += result.results
            totalPages = result.info.pages
            currentPage += 1
            //        } catch CharacterServiceError.noCharactersFound {
            //            resetSearch()
            //            return
        } catch {
            if isNewSearch { characters.removeAll() }
            errorMessage = "Error loading characters: \(error.localizedDescription)"
        }
    }
    
    func dismissError() {
        errorMessage = nil
    }
}
