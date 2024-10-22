//
//  String+ApplyingHighlight.swift
//  TelekomEmployeesDirectory
//
//  Created by AMALITECH-PC-105889 on 10/21/24.
//

import Foundation
import SwiftUICore

extension String {
    func applyingHighlight(to substring: String, highlightColor: Color = .theme) -> AttributedString {
        var attributedString = AttributedString(self)
        let lowercasedFullText = lowercased()
        let lowercasedHighlighted = substring.lowercased()

        if let range = lowercasedFullText.range(of: lowercasedHighlighted) {
            if let startIndex = attributedString.range(of: self[range.lowerBound ..< range.upperBound]) {
                attributedString[startIndex].foregroundColor = .theme
                attributedString[startIndex].font = .boldSystemFont(ofSize: 20)
            }
        }

        return attributedString
    }
}
