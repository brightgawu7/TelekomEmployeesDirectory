//
//  NavigationStackDataManager.swift
//  TelekomEmployeesDirectory
//
//  Created by AMALITECH-PC-105889 on 10/21/24.
//

import SwiftUI

@Observable
class NavigationManager {
    var navigationPath = NavigationPath()

    func push(_ view: NavigationScreens) {
        navigationPath.append(view)
    }

    func pop() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }

    func reset() {
        navigationPath = NavigationPath()
    }

    func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}


enum NavigationScreens: Hashable {
    case employeeDetail(Employee)
    case teamView(team: [Employee])
    case reportingLineView(reportingLines: [EmployeeReportingLine])
}
