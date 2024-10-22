//
//  EmployeeDataManaging.swift
//  TelekomEmployeesDirectory
//
//  Created by AMALITECH-PC-105889 on 10/21/24.
//

import Foundation

protocol EmployeeDataManaging {
    /// Fetches the list of employees, loading them from the file if the cache is empty.
    /// - Returns: An array of `Employee` objects.
    func fetchEmployees() async throws -> [Employee]

    /// Searches for employees by their name.
    /// - Parameter name: The name to search for.
    /// - Returns: An array of `Employee` objects matching the search criteria.
    func search(byName name: String) async -> [Employee]

    /// Fetches a single employee by their unique ID.
    /// - Parameter id: The UUID of the employee.
    /// - Returns: The `Employee` object
    func fetchEmployee(by id: UUID) async -> Employee

    /// Fetches employees belonging to a specific team by team ID.
    /// - Parameter id: The UUID of the team.
    /// - Returns: An array of `Employee` objects belonging to the specified team.
    func getEmployeesByTeam(withId id: UUID) async -> [Employee]

    /// Fetches the reporting line for employees using a list of UUIDs.
    /// - Parameter ids: An array of UUIDs representing employees in the reporting line.
    /// - Returns: An array of `EmployeeReportingLine` objects matching the provided UUIDs.
    func getEmployeeReportingLine(by ids: [UUID]) async -> [EmployeeReportingLine]
}
