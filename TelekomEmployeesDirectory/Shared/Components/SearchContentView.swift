//
//  SearchContentView.swift
//  TelekomDirectory
//
//  Created by AMALITECH-PC-105889 on 10/14/24.
//

import SwiftUI

struct SearchContentView: View {
    // MARK: - Properties

    @Environment(EmployeeSearchViewModel.self) private var viewModel

    var body: some View {
        VStack(alignment: .leading) {
            if viewModel.isLoading {
                LoadingSpinner()
            } else if shouldShowRecentSearches() {
                RecentSearchesView()
            } else if viewModel.placeholderText != nil {
                PlaceholderTextView(
                    placeholderText: viewModel.placeholderText ??
                        "No employees found for \"\(viewModel.searchText)\"."
                )
            } else if !viewModel.filteredEmployees.isEmpty {
                ContactsListView()
            } else {
                PlaceholderTextView()
            }
        }
    }

    // MARK: - Computed Properties

    private func shouldShowRecentSearches() -> Bool {
        return !viewModel.recentSearches.isEmpty && viewModel.searchText.isEmpty
    }
}

#Preview {
    BackgroundViewWrapper {
        SearchContentView()
            .environment(
                EmployeeSearchViewModel(
                    employeeDataManager: EmployeeDataManager(),
                    recentSearchesManager: RecentSearchesManager()
                )
            )
    }
}
