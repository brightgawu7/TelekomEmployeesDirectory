import SwiftUI

struct CustomSearchInput: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var body: some View {
        HStack(spacing: 10) {
            SearchIcon()

            TextField("Search", text: $text)
                .font(.customFont(.body, weight: .medium))
                .foregroundStyle(Color(.textPrimary))
                .keyboardType(.emailAddress)
                .focused($isFocused)

            ClearButton(isVisible: !text.isEmpty) {
                text = ""
                isFocused = false
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(color: .textPrimary.opacity(colorScheme == .light ? 1 : 0), radius: 2)
    }
}

#Preview {
    BackgroundViewWrapper {
        CustomSearchInput(text: .constant(""))
            .padding(.horizontal)
    }
}
