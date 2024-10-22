//
//  EmployeeSearch.swift
//  TelekomEmployeesDirectory
//
//  Created by AMALITECH-PC-105889 on 10/21/24.
//

import SwiftUI

struct EmployeeSearch: View {
    @State private var viewModel: EmployeeSearchViewModel = EmployeeSearchViewModel(
        employeeDataManager: Injected<EmployeeDataManaging>().wrappedValue,
        recentSearchesManager: Injected<RecentSearchesManaging>().wrappedValue)

    var body: some View {
        BackgroundViewWrapper {
            VStack {
                CustomSearchInput(text: $viewModel.searchText)
                SearchContentView()
                    .padding(.top, 15)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding(.horizontal, 8)
            .task {
                await viewModel.loadData()
            }
            .environment(viewModel)
        }
        .customNavigationTitle()
    }
}

#Preview {
    EmployeeSearch()
        .environment(NavigationManager())
        .environment(
            EmployeeSearchViewModel(
                employeeDataManager: EmployeeDataManager(),
                recentSearchesManager: RecentSearchesManager()
            )
        )
}
