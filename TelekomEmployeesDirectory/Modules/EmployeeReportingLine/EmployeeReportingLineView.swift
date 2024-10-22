//
//  EmployeeReportingLine.swift
//  TelekomEmployeesDirectory
//
//  Created by AMALITECH-PC-105889 on 10/21/24.
//

import SwiftUI

struct EmployeeReportingLineView: View {
    @Environment(NavigationManager.self) var navigationManager
    var reportingLines: [EmployeeReportingLine]

    var body: some View {
        BackgroundViewWrapper {
            VerticalStepperWrapper(sections: reportingLines.map { reportingLine in
                VerticalStepperSection(
                    title: reportingLine.name,
                    content:
                    reportingLine.employees.map { employee in
                        Button {
                            navigationManager.push(.employeeDetail(employee))

                        } label: {
                            EmployeeCard(employee: employee)
                        }
                    }
                )
            })
            .padding(.horizontal, 8)
            .padding(.top, 10)
            .navigationBarBackButtonHidden()
            .customNavigationTitle()

            .toolbar {
                CustomToolBarBackButton()
            }
        }
    }
}

#Preview {
    NavigationStack {
        BackgroundViewWrapper {
            EmployeeReportingLineView(reportingLines: [])
        }
        .environment(NavigationManager())
    }
}
