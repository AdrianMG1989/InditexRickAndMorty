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
            guard searchText.isEmpty || searchText.count >= minimumSearchLength else { return }
            guard !isFetchingPage else { return }
            await fetchCharacters(isNewSearch: true)
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
        
        guard shouldFetchCharacters(isNewSearch: isNewSearch) else { return }

        prepareForFetching()

        defer { finalizeFetching() }
        
        do {
            let fetchedCharacters = try await fetchPage()
            handleFetchedCharacters(fetchedCharacters, isNewSearch: isNewSearch)
        } catch {
            handleFetchError(error, isNewSearch: isNewSearch)
        }
    }
    
    private func shouldFetchCharacters(isNewSearch: Bool) -> Bool {
        guard !isFetchingPage else { return false }
        if isNewSearch {
            resetSearch()
        }
        return currentPage <= totalPages
    }

    private func prepareForFetching() {
        isLoading = true
        isFetchingPage = true
        errorMessage = nil
    }
    
    private func fetchPage() async throws -> CharacterResponse {
        return try await fetchCharactersUseCase.fetchCharactersWith(
            page: currentPage,
            name: searchText.isEmpty ? nil : searchText,
            status: selectedStatus.apiValue
        )
    }
    
    private func handleFetchedCharacters(_ response: CharacterResponse, isNewSearch: Bool) {
        guard !response.results.isEmpty else { return }
        characters += response.results
        totalPages = response.info.pages
        currentPage += 1
    }

    private func handleFetchError(_ error: Error, isNewSearch: Bool) {
        if isNewSearch {
            characters.removeAll()
        }
        errorMessage = "Error loading characters: \(error.localizedDescription)"
    }
    
    private func finalizeFetching() {
        isLoading = false
        isFetchingPage = false
    }
    
    func dismissError() {
        errorMessage = nil
    }
}
