import SwiftUI

struct RecentSearchesView: View {
    // MARK: - Properties

    @Environment(EmployeeSearchViewModel.self) private var viewModel: EmployeeSearchViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            SearchContentLabel(title: "Recent searches")
            ScrollView {
                LazyVGrid(columns: [.init(.flexible())], spacing: 15) {
                    ForEach(viewModel.recentSearches) { recentSearch in
                        Button {
                            withAnimation {
                                viewModel.searchText = recentSearch.name
                            }
                        } label: {
                            RecentSearchCard(searchItem: recentSearch) {
                                viewModel.removeRecentSearch(id: recentSearch.id)
                            }
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    BackgroundViewWrapper {
        RecentSearchesView()
            .environment(EmployeeSearchViewModel(
                employeeDataManager: EmployeeDataManager(),
                recentSearchesManager: RecentSearchesManager()
            ))
            .padding()
    }
}
