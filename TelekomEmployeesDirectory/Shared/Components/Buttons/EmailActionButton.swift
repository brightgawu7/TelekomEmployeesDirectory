import SwiftUI

struct EmailActionButton: View {
    // MARK: - PROPERTIES

    var emailAddress: String?
    var isButtonDisabled: Bool {
        emailAddress?.isEmpty ?? true
    }

    var body: some View {
        CircularIconButton(
            font: .customFont(.title3, weight: .thin),
            systemIconName: "envelope",
            backgroundColor: .textPrimary.opacity(0),
            iconColor: .theme,
            isButtonDisabled: isButtonDisabled,
            action: {
                EmailSendingHelper.sendEmail(to: emailAddress)
            }
        ).overlay {
            Circle()
                .stroke(.theme, style: StrokeStyle(lineWidth: .init(isButtonDisabled ? 0 : 1)))
        }
    }
}

#Preview {
    BackgroundViewWrapper {
        VStack {
            EmailActionButton(emailAddress: "example@example.com")

            EmailActionButton(emailAddress: nil)
        }
    }
}
