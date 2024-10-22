//
//  CustomToolBarBackButton.swift
//  TelekomEmployeesDirectory
//
//  Created by AMALITECH-PC-105889 on 10/21/24.
//

import SwiftUI

struct CustomToolBarBackButton: ToolbarContent {
    @Environment(\.dismiss) var dismiss
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                dismiss()
            } label: {
                HStack(spacing: 8) {
                    Image(.backIcon)
                        .resizable()
                        .frame(width: 10, height: 14)
                    Text("Back")
                }
                .font(.customFont(.callout, weight: .medium))
                .foregroundStyle(.theme)
            }
        }
    }
}


