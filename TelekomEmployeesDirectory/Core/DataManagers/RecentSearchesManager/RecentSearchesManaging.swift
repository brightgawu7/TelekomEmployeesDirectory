//
//  RecentSearchesManaging.swift
//  TelekomEmployeesDirectory
//
//  Created by AMALITECH-PC-105889 on 10/21/24.
//

import Foundation

protocol RecentSearchesManaging: AnyObject {
    /// Loads recent searches from persistent storage into the cache.
    func getRecentSearches() async -> [RecentSearchItem]

    /// Retrieves the cached recent searches. If the cache is empty, it loads from storage.
    /// - Returns: An array of `RecentSearchItem` objects.
    func loadRecentSearches() async

    /// Adds a new recent search to the cache and updates persistent storage.
    /// - Parameters:
    ///   - id: The UUID of the search item.
    ///   - name: The name of the search item.
    func addRecentSearch(id: UUID, name: String) async

    /// Removes a recent search item from the cache by its ID and updates persistent storage.
    /// - Parameter id: The UUID of the search item to remove.
    func removeRecentSearch(by id: UUID) async
}
