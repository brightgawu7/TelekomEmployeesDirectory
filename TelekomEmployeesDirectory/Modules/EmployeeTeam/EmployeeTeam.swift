import SwiftUI

struct EmployeeTeam: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel: EmployeeTeamViewModel

    init(employeeTeam: [Employee]) {
        viewModel = .init(
            employeeTeam: employeeTeam,
            employeeDataManager: Injected<EmployeeDataManaging>().wrappedValue
        )
    }

    var body: some View {
        BackgroundViewWrapper {
            VStack(spacing: 15) {
                EmployeeFilterView(viewModel: viewModel)
                ScrollView {
                    VStack {
                        if viewModel.filteredEmployeeTeam.isEmpty {
                            PlaceholderTextView(placeholderText: "No employees found.")
                                .padding(.top, 20)
                        } else {
                            EmployeeGridView(viewModel: viewModel)
                        }
                    }
                }
            }
            .padding()
            .customNavigationTitle()
            .navigationBarBackButtonHidden()
            .toolbar {
                CustomToolBarBackButton()
            }
        }
    }
}

// MARK: - Employee Grid View
private struct EmployeeGridView: View {
    @Environment(NavigationManager.self) var navigationManager
    var viewModel: EmployeeTeamViewModel

    var body: some View {
        LazyVGrid(columns: [.init(.flexible())]) {
            ForEach(viewModel.filteredEmployeeTeam) { employee in
                Button {
                    withAnimation {
                        navigationManager.push(.employeeDetail(employee))
                    }
                } label: {
                    EmployeeCard(employee: employee, searchText: "")
                }
            }
        }
        .padding(5)
    }
}

// MARK: - Employee Filter View
private struct EmployeeFilterView: View {
    var viewModel: EmployeeTeamViewModel

    var body: some View {
        HStack(spacing: 10) {
            FilterButton(title: "All", isSelected: viewModel.selectedEmployeeType == nil) {
                viewModel.filterEmployeeTeam(withType: nil)
            }

            ForEach(EmployeeType.allCases, id: \.self) { type in
                FilterButton(title: type.rawValue.capitalized, isSelected: viewModel.selectedEmployeeType == type) {
                    viewModel.filterEmployeeTeam(withType: type)
                }
            }
        }
        .padding(2)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Filter Button
private struct FilterButton: View {
    @Environment(\.colorScheme) var colorScheme
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .padding(.vertical, 6)
                .padding(.horizontal, 20)
                .font(.customFont(.callout))
                .foregroundStyle(isSelected ? .white : .textPrimary)
                .background(isSelected ? .accent : .backgroundSecondary)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .customBoxShadow()
        }
    }
}


#Preview {
    EmployeeTeam(employeeTeam: [])
        .environment(NavigationManager())
}
