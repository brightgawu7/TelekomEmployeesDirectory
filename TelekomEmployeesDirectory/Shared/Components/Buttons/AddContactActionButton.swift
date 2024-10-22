import SwiftUI
import Contacts

struct AddContactActionButton: View {
    var employee: Employee

    var body: some View {
        CircularIconButton(
            font: .customFont(.title3, weight: .thin),
            systemIconName: "plus",
            backgroundColor: .textPrimary.opacity(0),
            iconColor: .theme,
            isButtonDisabled: false,
            action: {
             
            }
        ).overlay {
            Circle()
                .stroke(.theme, style: StrokeStyle(lineWidth: .init(1)))
        }
    }
}

#Preview {
    BackgroundViewWrapper {
        AddContactActionButton(employee: mockEmployee)
    }
}
