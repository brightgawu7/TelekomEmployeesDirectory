//
//  EmployeeDetailViewManager.swift
//  TelekomEmployeesDirectory
//
//  Created by AMALITECH-PC-105889 on 10/21/24.
//

import SwiftUI

@Observable
class EmployeeDetailViewModel {
    @ObservationIgnored var employeeManager: EmployeeDataManaging

    init(employeeManager: EmployeeDataManaging) {
        self.employeeManager = employeeManager
    }

    func getEmployeeReportingLine(ids: [UUID]) async -> [EmployeeReportingLine] {
        try? await   Task.sleep(for: .seconds(1))
        return await employeeManager.getEmployeeReportingLine(by: ids)
    }
    
    
    func fetchEmployeeTeam(teamId: UUID) async -> [Employee] {
        try? await   Task.sleep(for: .seconds(1))
        return await employeeManager.getEmployeesByTeam(withId: teamId)
    }
}
