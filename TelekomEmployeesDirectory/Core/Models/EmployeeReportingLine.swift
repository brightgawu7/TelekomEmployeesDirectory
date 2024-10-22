//
//  EmployeeReportingLine.swift
//  TelekomDirectory
//
//  Created by AMALITECH-PC-105889 on 10/16/24.
//

import Foundation

struct EmployeeReportingLine: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let employees: [Employee]
}
