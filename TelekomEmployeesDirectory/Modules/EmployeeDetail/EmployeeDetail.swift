//
//  EmployeeDetail.swift
//  TelekomEmployeesDirectory
//
//  Created by AMALITECH-PC-105889 on 10/21/24.
//

import SwiftUI

struct EmployeeDetail: View {
    @Environment(\.dismiss) var dismiss
    @Environment(NavigationManager.self) var navigationManager
    @State private var viewModel = EmployeeDetailViewModel(employeeManager: Injected<EmployeeDataManaging>().wrappedValue)
    @State var employee: Employee

    var body: some View {
        BackgroundViewWrapper {
            ScrollView {
                VStack(spacing: 24) {
                    PhotoAvatar(imageURL: URL(string: employee.image ?? ""), size: 190)
                        .padding(.top, 40)

                    EmployeeInfoView(employee: employee)

                    EmployeeContactActionsView(employee: employee)

                    EmployeeTeamAndReportingView(employee: employee, viewModel: viewModel)
                }
                .padding(.horizontal, 8)
            }
        }
        .customNavigationTitle()
        .navigationBarBackButtonHidden()
        .toolbar {
            CustomToolBarBackButton()
        }
    }
}

// MARK: - Employee Info View

private struct EmployeeInfoView: View {
    let employee: Employee

    var body: some View {
        VStack(spacing: 4) {
            Text(employee.name)
                .font(.customFont(.title3, weight: .bold))
                .foregroundStyle(.theme)

            Group {
                Text(employee.address.office)
                Text(employee.team.name)
            }
            .font(.customFont(.body))
            .foregroundStyle(Color(.textSecondary))

            HStack {
                Text(employee.address.city)
                Text(employee.address.street)
                Text(employee.address.country)
            }
            .font(.customFont(.footnote))
            .foregroundStyle(Color(.textSecondary))

            Group {
                if let phone = employee.phone, !phone.isEmpty {
                    Text("Mobile \(phone)")
                }

                if let email = employee.email, !email.isEmpty {
                    Text(email)
                }
            }
            .font(.customFont(.body, weight: .medium))
            .foregroundStyle(.theme)
        }
    }
}

// MARK: - Employee Contact Actions View

private struct EmployeeContactActionsView: View {
    let employee: Employee

    var body: some View {
        HStack(spacing: 8) {
            PhoneActionButton(phoneNumber: employee.phone)
            EmailActionButton(emailAddress: employee.email)
            AddContactActionButton(employee: employee)
        }
    }
}

// MARK: - Employee Team and Reporting View

private struct EmployeeTeamAndReportingView: View {
    let employee: Employee
    var viewModel: EmployeeDetailViewModel

    var body: some View {
        VStack(spacing: 16) {
            TeamButtonView(employee: employee, viewModel: viewModel)

            Group {
                Rectangle()
                    .fill(.textSecondary)
                    .frame(height: 1)
            }.padding(.trailing, 40)

            ReportingLineButtonView(employee: employee, viewModel: viewModel)
        }
        .font(.customFont(.body))
        .foregroundStyle(Color(.textPrimary))
        .padding(.horizontal, 16)
        .padding(.vertical, 32)
        .background(Color(.backgroundSecondary))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .customBoxShadow()
    }
}

// MARK: - Team Button View

private struct TeamButtonView: View {
    let employee: Employee
    var viewModel: EmployeeDetailViewModel
    @State var isLoading: Bool = false
    @Environment(NavigationManager.self) var navigationManager

    var body: some View {
        Button {
            Task{ @MainActor in
                await fetchTeam()
            }
        } label: {
            HStack {
                Text(employee.team.name)
                    .multilineTextAlignment(.leading)
                Spacer()
                if isLoading {
                    LoadingSpinner()
                } else {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.textSecondary)
                        .font(.headline)
                        .opacity(0.5)
                }
            }
        }
    }

    // Fetches the reporting line data asynchronously
    private func fetchTeam() async {
        isLoading = true
        let employeeTeam = await viewModel.fetchEmployeeTeam(teamId: employee.team.id)
        isLoading = false
        navigationManager.push(.teamView(team: employeeTeam))
    }
}

// MARK: - Reporting Line Button View

private struct ReportingLineButtonView: View {
    let employee: Employee
    var viewModel: EmployeeDetailViewModel
    @State var isLoading: Bool = false
    @Environment(NavigationManager.self) var navigationManager

    var body: some View {
        Button {
            Task { @MainActor in
                await fetchReportingLines()
            }
        } label: {
            HStack {
                Text("Reporting line")
                    .multilineTextAlignment(.leading)
                Spacer()
                if isLoading {
                    LoadingSpinner()
                } else {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.textSecondary)
                        .font(.headline)
                        .opacity(0.5)
                }
            }
        }
    }

    // Fetches the reporting line data asynchronously
    private func fetchReportingLines() async {
        isLoading = true
        let reportingLines = await viewModel.getEmployeeReportingLine(ids: employee.reportingLines)
        isLoading = false
        navigationManager.push(.reportingLineView(reportingLines: reportingLines))
    }
}

// MARK: Preview

#Preview {
    EmployeeDetail(employee: mockEmployee)
        .environment(NavigationManager())
}
