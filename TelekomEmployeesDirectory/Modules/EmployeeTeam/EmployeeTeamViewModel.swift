//
//  EmployeeTeamViewModel.swift
//  TelekomEmployeesDirectory
//
//  Created by AMALITECH-PC-105889 on 10/21/24.
//

import SwiftUI

@Observable
class EmployeeTeamViewModel{
    @ObservationIgnored var employeeTeam: [Employee] = []
    var filteredEmployeeTeam: [Employee] = []
    var selectedEmployeeType: EmployeeType?

   @ObservationIgnored var employeeDataManager: EmployeeDataManaging
    
    init(employeeTeam: [Employee], employeeDataManager: EmployeeDataManaging) {
        self.employeeTeam = employeeTeam
        self.filteredEmployeeTeam = employeeTeam
        self.employeeDataManager = employeeDataManager
    }
    

    func filterEmployeeTeam(withType type: EmployeeType?) {
        selectedEmployeeType = type
        guard let type else {
            filteredEmployeeTeam = employeeTeam
            return
        }
        filteredEmployeeTeam = employeeTeam.filter { $0.employeeType == type }
    }
}
