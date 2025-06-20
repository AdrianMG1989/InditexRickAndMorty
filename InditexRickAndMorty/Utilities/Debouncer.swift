//
//  Debouncer.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 20/6/25.
//

import Foundation

@MainActor
final class Debouncer {
    private var task: Task<Void, Never>?
    private let delay: TimeInterval

    init(delay: TimeInterval) {
        self.delay = delay
    }

    func call(_ action: @escaping () async -> Void) {
        task?.cancel()
        task = Task {
            try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
            guard !Task.isCancelled else { return }
            await action()
        }
    }

    func cancel() {
        task?.cancel()
    }
}
