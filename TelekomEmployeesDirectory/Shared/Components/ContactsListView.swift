//
//  ContactsListView.swift
//  TelekomDirectory
//
//  Created by AMALITECH-PC-105889 on 10/14/24.
//

import SwiftUI

struct ContactsListView: View {
    @Environment(EmployeeSearchViewModel.self) private var viewModel
    @Environment(NavigationManager.self) private var navigationManager

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            SearchContentLabel(title: "Contacts")

            ScrollView {
                LazyVGrid(columns: [.init(.flexible())]) {
                    ForEach(viewModel.filteredEmployees) { employee in
                        Button {
                            viewModel.addRecentSearch(id: employee.id, name: employee.name)
                            navigationManager.push(.employeeDetail(employee))
                        } label: {
                            EmployeeCard(employee: employee, searchText: viewModel.searchText)
                        }
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 5)
            }
        }
    }
}

#Preview {
    BackgroundViewWrapper {
        ContactsListView()
            .padding()
    }
    .environment(
        EmployeeSearchViewModel(
            employeeDataManager: EmployeeDataManager(),
            recentSearchesManager: RecentSearchesManager()
        )
    )
    .environment(NavigationManager())
}
