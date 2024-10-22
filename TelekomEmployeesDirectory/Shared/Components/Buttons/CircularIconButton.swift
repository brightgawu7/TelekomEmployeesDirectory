import SwiftUI

struct CircularIconButton: View {
    // MARK: - PROPERTIES
    var font: Font?
    var systemIconName: String
    var backgroundColor: Color
    var iconColor: Color?
    var isButtonDisabled: Bool = false
    var action: (() -> Void)?

    var body: some View {
        Button(action: {
            action?()
        }, label: {
            Image(systemName: systemIconName)
                .font(font ?? .customFont(.title3, weight: .bold))
                .foregroundColor(iconColor ?? .white)
                .padding(14)
                .background(isButtonDisabled ? Color(.textPrimary.opacity(0.2)) : backgroundColor)
                .clipShape(Circle())
        })
        .disabled(isButtonDisabled)
    }
}

#Preview {
    BackgroundViewWrapper {
        CircularIconButton(
            systemIconName: "arrow.2.circlepath.circle",
            backgroundColor: .init(.backgroundPrimary),
            iconColor: .black,
            action: {
            }
        )
    }
}
