/**
 A view that displays a magnifying glass icon for search functionality.
 */

import SwiftUI
import SwiftUICore

struct SearchIcon: View {
    var size: Font = .customFont(.title3)

    var body: some View {
        Image(systemName: "magnifyingglass")
            .foregroundStyle(.textPrimary)
            .font(size)
    }
}

#Preview {
    BackgroundViewWrapper {
        SearchIcon()
    }
}
