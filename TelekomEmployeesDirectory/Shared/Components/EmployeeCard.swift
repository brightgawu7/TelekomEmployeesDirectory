//
//  EmployeeCard.swift
//  TelekomDirectory
//
//  Created by AMALITECH-PC-105889 on 10/13/24.
//

import SwiftUI

struct EmployeeCard: View {
    @Environment(\.colorScheme) var colorScheme
    var employee: Employee
    var searchText: String?

    var body: some View {
        HStack {
            PhotoAvatar(imageURL: URL(string: employee.image ?? ""))
            Spacer()
            VStack(alignment: .leading, spacing: 2) {
                Text(employee.name.applyingHighlight(to: searchText ?? ""))
                    .font(.customFont(.title3))
                    .foregroundStyle(.textPrimary)
                    .foregroundStyle( searchText == nil  ? .textPrimary : .textSecondary)
                Text(employee.team.name)
                    .font(.customFont(.footnote))
                    .foregroundStyle(.textSecondary)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            Spacer()
            HStack(spacing: 2) {
                PhoneActionButton(phoneNumber: employee.phone)
                EmailActionButton(emailAddress: employee.email)
            }
        }
        .padding(16)
        .background(Color(.backgroundSecondary))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .customBoxShadow()
        .transition(.opacity.animation(.linear(duration: 0.3)))
    }

    private var shadowColor: Color {
        .black.opacity(colorScheme == .light ? 0.03 : 0)
    }
}

#Preview {
    BackgroundViewWrapper {
        EmployeeCard(employee: mockEmployee, searchText: "John")
            .padding()
    }
}
