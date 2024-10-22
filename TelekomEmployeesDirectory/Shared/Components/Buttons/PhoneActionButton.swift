//
//  PhoneActionButton.swift
//  TelekomDirectory
//
//  Created by AMALITECH-PC-105889 on 10/13/24.
//

import SwiftUI

struct PhoneActionButton: View {
    // MARK: - PROPERTIES

    var phoneNumber: String?
    var isButtonDisabled: Bool {
        phoneNumber?.isEmpty ?? true
    }

    var body: some View {
        CircularIconButton(
            font: .customFont(.title3, weight: .thin),
            systemIconName: "phone.fill",
            backgroundColor: .accent,
            iconColor: .white,
            isButtonDisabled: isButtonDisabled,
            action: {
                PhoneDialingHelper.dial(phoneNumber: phoneNumber)
            }
        )
    }
}

#Preview {
    BackgroundViewWrapper {
        VStack {
            PhoneActionButton(phoneNumber: "+1234567890")

            PhoneActionButton(phoneNumber: nil)
        }
    }
}
