//
//  ContainerFactory.swift
//  TelekomDirectory
//
//  Created by AMALITECH-PC-105889 on 10/16/24.
//

import Swinject

struct ContainerFactory {
    static func buildContainer() -> Container {
        let container = Container()
        registerDependencies(in: container)
        return container
    }

    private static func registerDependencies(in container: Container) {
        container.register(EmployeeDataManaging.self) { _ in
            EmployeeDataManager()
        }
        .inObjectScope(.container)

        container.register(RecentSearchesManaging.self) { _ in
            RecentSearchesManager()
        }
        .inObjectScope(.container)
    }
}
