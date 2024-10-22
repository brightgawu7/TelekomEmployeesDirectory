//
//  RecentSearchCard.swift
//  TelekomDirectory
//
//  Created by AMALITECH-PC-105889 on 10/13/24.
//

import SwiftUI

struct RecentSearchCard: View {
    let searchItem: RecentSearchItem
    let clearAction: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 20) {
                Image(systemName: "clock")
                Text(searchItem.name)
                Spacer()
                Button {
                    clearAction?()

                } label: {
                    Image(systemName: "xmark")
                        .font(.customFont(.footnote))
                }
            }
            Group {
                Rectangle()
                    .fill(.textSecondary)
                    .frame(height: 1)
            }.padding(.trailing, 50)
        }
        .font(.customFont(.body))
        .foregroundStyle(.textPrimary)
        .multilineTextAlignment(.leading)
    }
}

#Preview {
    BackgroundViewWrapper {
        RecentSearchCard(
            searchItem:
            RecentSearchItem(id: UUID(),
                             name: "Bright Edem Gawu"), clearAction: nil)
            .padding()
    }
}
