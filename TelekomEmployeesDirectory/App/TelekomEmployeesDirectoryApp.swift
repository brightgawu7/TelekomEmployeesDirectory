//
//  TelekomEmployeesDirectoryApp.swift
//  TelekomEmployeesDirectory
//
//  Created by AMALITECH-PC-105889 on 10/19/24.
//

import SwiftUI

@main
struct TelekomEmployeesDirectoryApp: App {
    @State private var navigationManager: NavigationManager = .init()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationManager.navigationPath) {
                EmployeeSearch()
                    .setupNavigation()
            }
            .environment(navigationManager)
        }
    }
}
