//
//  EmployeeDataManager.swift
//  TelekomDirectory
//
//  Created by AMALITECH-PC-105889 on 10/14/24.
//

import Foundation

actor EmployeeDataManager: EmployeeDataManaging {
    // MARK: - Properties

    private var employeeCache: [Employee] = []
    private var reportingLineCache: [EmployeeReportingLine] = []

    func fetchEmployees() async throws -> [Employee] {
        if employeeCache.isEmpty {
            employeeCache = loadEmployeesFromFile()
        }
        return employeeCache
    }

    // MARK: - Public Methods

    func search(byName name: String) async -> [Employee] {
        return name.isEmpty ? [] : filterEmployees(by: name)
    }

    func fetchEmployee(by id: UUID) async -> Employee {
        return employeeCache.first { $0.id == id } ?? mockEmployee
    }

    func getEmployeesByTeam(withId id: UUID) async -> [Employee] {
        return filterEmployeesByTeam(withId: id)
    }

    func getEmployeeReportingLine(by ids: [UUID]) async -> [EmployeeReportingLine] {
        if reportingLineCache.isEmpty {
            reportingLineCache = Bundle.main.decode("reportingLine.json") as [EmployeeReportingLine]
        }
        return reportingLineCache.filter { ids.contains($0.id) }
    }

    // MARK: - Private Helpers

    /// Loads the list of employees from the "employees.json" file.
    /// - Returns: An array of `Employee` objects loaded from the file.
    private func loadEmployeesFromFile() -> [Employee] {
        return Bundle.main.decode("employees.json") as [Employee]
    }

    /// Filters employees based on a provided name.
    /// - Parameter name: The name to filter employees by.
    /// - Returns: An array of `Employee` objects whose names contain the search string.
    private func filterEmployees(by name: String) -> [Employee] {
        return employeeCache.filter { $0.name.lowercased().contains(name.lowercased()) }
    }

    /// Filters employees by a specific team ID.
    /// - Parameter id: The UUID of the team.
    /// - Returns: An array of `Employee` objects belonging to the team.
    private func filterEmployeesByTeam(withId id: UUID) -> [Employee] {
        return employeeCache.filter { $0.team.id == id }
    }
}
