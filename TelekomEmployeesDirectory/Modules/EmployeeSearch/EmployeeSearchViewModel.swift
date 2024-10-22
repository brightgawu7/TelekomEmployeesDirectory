//
//  EmployeeSearchViewModel.swift
//  TelekomEmployeesDirectory
//
//  Created by AMALITECH-PC-105889 on 10/21/24.
//
import Combine
import SwiftUI

@Observable
class EmployeeSearchViewModel {
    // MARK: - Properties

    var searchText: String = "" {
        didSet {
            debouncedSearchText.send(searchText)
        }
    }

    var isLoading: Bool = false
    var filteredEmployees: [Employee] = []
    var recentSearches: [RecentSearchItem] = []
    var placeholderText: String?

    @ObservationIgnored private var employeeDataManager: EmployeeDataManaging
    @ObservationIgnored private var recentSearchesManager: RecentSearchesManaging
    @ObservationIgnored private var cancellables = Set<AnyCancellable>()
    @ObservationIgnored private var debouncedSearchText = CurrentValueSubject<String, Never>("")

    /// Initializes the view model with employee and recent search managers.
    /// - Parameters:
    ///   - employeeDataManager: Manager for fetching employee data.
    ///   - recentSearchesManager: Manager for handling recent searches.
    init(employeeDataManager: EmployeeDataManaging, recentSearchesManager: RecentSearchesManaging) {
        self.employeeDataManager = employeeDataManager
        self.recentSearchesManager = recentSearchesManager

        setupSearchDebouncer()
    }

    /// Loads initial data including all employees and recent searches.
    @MainActor
    func loadData() async {
        var _ = try? await employeeDataManager.fetchEmployees()
        recentSearches = await recentSearchesManager.getRecentSearches()
    }

    /// Fetches an employee by their unique ID.
    /// - Parameter id: The UUID of the employee to fetch.
    /// - Returns: An `Employee` object corresponding to the provided ID.
    func fetchEmployee(withId id: UUID) async -> Employee {
        await employeeDataManager.fetchEmployee(by: id)
    }

    /// Adds a new search item to recent searches and updates the view.
    /// - Parameters:
    ///   - id: The UUID of the searched employee.
    ///   - name: The name of the searched employee.
    func addRecentSearch(id: UUID, name: String) {
        Task { @MainActor in
            await recentSearchesManager.addRecentSearch(id: id, name: name)
            await updateRecentSearches()
        }
    }

    /// Removes a search item from recent searches by its ID.
    /// - Parameter id: The UUID of the search item to remove.
    func removeRecentSearch(id: UUID) {
        Task { @MainActor in
            await recentSearchesManager.removeRecentSearch(by: id)
            await updateRecentSearches()
        }
    }

    // MARK: - Private Methods

    /// Sets up a debouncer to delay search operations until the user stops typing for a short duration.
    private func setupSearchDebouncer() {
        debouncedSearchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .dropFirst()
            .sink { [weak self] text in
                self?.performEmployeeSearch(with: text)
            }
            .store(in: &cancellables)
    }

    /// Performs a search for employees based on the entered text.
    /// - Parameter searchText: The text used to search for employees.
    private func performEmployeeSearch(with searchText: String) {
        guard !(searchText.count < 3) else {
            resetFilteredEmployees()
            return
        }

        Task { @MainActor in
            isLoading = true
            try? await Task.sleep(for: .milliseconds(700))
            self.filteredEmployees = await employeeDataManager.search(byName: searchText)
            self.placeholderText = filteredEmployees.isEmpty ? "No employees found for \"\(searchText)\"." : nil
            isLoading = false
        }
    }

    /// Resets the list of filtered employees and clears the placeholder text.
    private func resetFilteredEmployees() {
        filteredEmployees = []
        placeholderText = nil
        isLoading = false
    }

    // MARK: - Private Helpers

    /// Updates the recent searches list by fetching the latest data.
    private func updateRecentSearches() async {
        recentSearches = await recentSearchesManager.getRecentSearches()
    }
}
