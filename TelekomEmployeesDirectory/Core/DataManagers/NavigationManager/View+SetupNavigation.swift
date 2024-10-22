//
//  NavigationStack+SetupNavigation.swift
//  TelekomEmployeesDirectory
//
//  Created by AMALITECH-PC-105889 on 10/21/24.
//

import SwiftUI

extension View {
    func setupNavigation() -> some View {
        navigationDestination(for: NavigationScreens.self) { screen in
            switch screen {
            case let .employeeDetail(employee):
                EmployeeDetail(employee: employee)
            case let .teamView(team):
                EmployeeTeam(employeeTeam : team)
            case let .reportingLineView(reportingLines):
                EmployeeReportingLineView(reportingLines: reportingLines)
            }
        }
    }
}
