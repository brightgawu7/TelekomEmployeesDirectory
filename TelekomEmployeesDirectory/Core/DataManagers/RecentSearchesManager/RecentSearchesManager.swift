//
//  RecentSearchesManager.swift
//  TelekomDirectory
//
//  Created by AMALITECH-PC-105889 on 10/16/24.
//

import SwiftUI

actor RecentSearchesManager: RecentSearchesManaging {
    // MARK: - Properties

    @AppStorage("RecentSearches") private var recentSearchesData: Data = .init()

    private var recentSearchCache: [RecentSearchItem] = []

    // MARK: - Public Properties

    func loadRecentSearches() async {
        recentSearchCache = decodeRecentSearches(from: recentSearchesData) ?? []
    }

    func getRecentSearches() async -> [RecentSearchItem] {
        if recentSearchCache.isEmpty {
            await loadRecentSearches()
        }
        return recentSearchCache
    }

    func addRecentSearch(id: UUID, name: String) async {
        let newSearchItem = RecentSearchItem(id: id, name: name)
        updateRecentSearchCache(with: newSearchItem)
        await persistRecentSearches()
    }

    func removeRecentSearch(by id: UUID) async {
        recentSearchCache.removeAll(where: { $0.id == id })
        await persistRecentSearches()
    }

    // MARK: - Private Helpers

    /// Updates the recent search cache by adding a new item and limiting the cache size to 10 items.
    /// - Parameter newSearchItem: The new search item to add.
    private func updateRecentSearchCache(with newSearchItem: RecentSearchItem) {
        // Remove any previous search item with the same ID
        recentSearchCache.removeAll(where: { $0.id == newSearchItem.id })

        // Insert the new item at the top of the list
        recentSearchCache.insert(newSearchItem, at: 0)

        // Limit the cache to the most recent 10 items
        if recentSearchCache.count > 10 {
            recentSearchCache = Array(recentSearchCache.prefix(10))
        }
    }

    /// Persists the recent search cache by encoding it into `Data` and saving it to persistent storage.
    private func persistRecentSearches() async {
        recentSearchesData = encodeRecentSearches(recentSearchCache) ?? Data()
    }

    /// Decodes recent search items from a `Data` object.
    /// - Parameter data: The encoded data representing recent search items.
    /// - Returns: An array of `RecentSearchItem` objects, or `nil` if decoding fails.
    private func decodeRecentSearches(from data: Data) -> [RecentSearchItem]? {
        return try? JSONDecoder().decode([RecentSearchItem].self, from: data)
    }

    /// Encodes an array of recent search items into a `Data` object.
    /// - Parameter searches: The array of `RecentSearchItem` objects to encode.
    /// - Returns: A `Data` object containing the encoded search items, or `nil` if encoding fails.
    private func encodeRecentSearches(_ searches: [RecentSearchItem]) -> Data? {
        return try? JSONEncoder().encode(searches)
    }
}
