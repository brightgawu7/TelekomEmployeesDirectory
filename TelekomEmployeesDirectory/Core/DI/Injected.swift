//
//  Injected.swift
//  TelekomDirectory
//
//  Created by AMALITECH-PC-105889 on 10/16/24.
//

@propertyWrapper
struct Injected<T> {
    let wrappedValue: T

    init() {
        guard let resolved = AppContainer.shared.container.resolve(T.self) else {
            fatalError("Dependency \(T.self) could not be resolved. Make sure it is registered with Swinject.")
        }
        wrappedValue = resolved
    }
}
