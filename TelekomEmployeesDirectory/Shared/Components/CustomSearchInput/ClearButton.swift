/**
 A button that clears the search text when tapped.
 */

import SwiftUI
import SwiftUICore

struct ClearButton: View {
    var isVisible: Bool
    var action: () -> Void
    var size: Font = .customFont(.title3)

    var body: some View {
        Button(action: action) {
            if isVisible {
                Image(systemName: "x.circle.fill")
                    .foregroundStyle(.textPrimary)
                    .font(size)
                    .transition(.opacity)
            }
        }
    }
}

#Preview {
    BackgroundViewWrapper {
        ClearButton(isVisible: true) {}
    }
}
