//
//  ViewModifiers.swift
//  TelekomEmployeesDirectory
//
//  Created by AMALITECH-PC-105889 on 10/21/24.
//

import SwiftUICore

struct CustomNavigationTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationTitle(LocalizedStringKey("AppName"))
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct CustomBoxShadow: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .shadow(color: shadowColor, radius: 0)
            .shadow(color: shadowColor, radius: 7, x: 0, y: 3)
            .shadow(color: shadowColor, radius: 12, x: 0, y: 12)
            .shadow(color: shadowColor, radius: 20, x: 0, y: 49)
            .shadow(color: shadowColor, radius: 20, x: 0, y: 49)
            .shadow(color: shadowColor, radius: 12, x: 0, y: 4)
    }

    private var shadowColor: Color {
        .black.opacity(colorScheme == .light ? 0.03 : 0)
    }
}

extension View {
    func customNavigationTitle() -> some View {
        modifier(CustomNavigationTitle())
    }

    func customBoxShadow() -> some View {
        modifier(CustomBoxShadow())
    }
}
