//
//  Font+CustomFont.swift
//  TelekomEmployeesDirectory
//
//  Created by AMALITECH-PC-105889 on 10/20/24.
//
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Font {
    public static func customFont(
        _ textStyle: Font.TextStyle,
        weight: CustomFontWeight? = nil
    ) -> Font {
        createCustomFont(for: textStyle, weight: weight)
    }
}
