//
//  AppContainer.swift
//  TelekomEmployeesDirectory
//
//  Created by AMALITECH-PC-105889 on 10/20/24.
//

import Swinject

final class AppContainer {
    static let shared = AppContainer()

    private var _container: Container?

    var container: Container {
        get {
            if _container == nil {
                _container = ContainerFactory.buildContainer()
            }
            return _container!
        }
        set {
            _container = newValue
        }
    }
}
