//
//  CustomFont.swift
//  TelekomEmployeesDirectory
//
//  Created by AMALITECH-PC-105889 on 10/20/24.
//
import SwiftUI

let customFontFamily = "TeleNeo"

public enum CustomFontWeight {
    case regular
    case medium
    case bold
    case thin

    var weight: Font.Weight {
        switch self {
        case .regular: return .regular
        case .medium: return .medium
        case .bold: return .bold
        case .thin: return .thin
        }
    }
}

func fontSize(for textStyle: Font.TextStyle) -> CGFloat {
    return fontSizeMapping[textStyle] ?? 16
}

private let fontSizeMapping: [Font.TextStyle: CGFloat] = [
    .largeTitle: 34,
    .title: 28,
    .title2: 22,
    .title3: 20,
    .headline: 17,
    .body: 17,
    .callout: 16,
    .subheadline: 15,
    .footnote: 13,
    .caption: 12,
    .caption2: 11
]

func createCustomFont(
    for textStyle: Font.TextStyle,
    fontFamily: String = customFontFamily,
    weight: CustomFontWeight? = nil
) -> Font {
    let fontSize = fontSize(for: textStyle)
    let fontWeight = weight?.weight ?? .regular

    return Font.custom(fontFamily, size: fontSize, relativeTo: textStyle)
        .weight(fontWeight)
}
