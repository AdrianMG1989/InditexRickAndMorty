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
    @Published var showErrorAlert = false
    @Published var searchText: String = "" {
        didSet {
            updateSearchText()
        }
    }
    @Published var selectedStatus: FilterStatus = .all{
        didSet {
            updateFilter()
        }
    }
    @Published var errorMessage: String? {
        didSet {
            showErrorAlert = errorMessage != nil
        }
    }
    
    private let fetchCharactersUseCase: FetchCharactersUseCaseProtocol
    private var currentPage = 1
    private var totalPages = 1
    private let minimumSearchLength = 3
    var isFetchingPage = false
    var debounceTask: Task<Void, Never>?
    private let debouncer = Debouncer(delay: 0.6)
    
    var onCharacterSelected: ((Character) -> Void)?
    
    init(fetchCharactersUseCase: FetchCharactersUseCaseProtocol) {
        self.fetchCharactersUseCase = fetchCharactersUseCase
        loadInitialData()
    }

    private func loadInitialData(){
        Task {
            await fetchCharacters(isNewSearch: true)
        }
    }
    
    func characterTapped(_ character: Character) {
        onCharacterSelected?(character)
    }
    
    func updateSearchText() {
        debouncer.call { [weak self] in
            guard let self = self else { return }
            guard self.searchText.isEmpty || self.searchText.count >= self.minimumSearchLength else { return }
            guard !self.isFetchingPage else { return }
            await self.fetchCharacters(isNewSearch: true)
        }
    }
    
    func updateFilter() {
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
    
    func fetchCharacters(isNewSearch: Bool) async {
        
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
