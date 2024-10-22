import SwiftUI

struct BackgroundViewWrapper<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            Color(.darkGrayBackground)
                .ignoresSafeArea()
            content
        }
    }
}

#Preview {
    BackgroundViewWrapper {
        Text(LocalizedStringKey("AppName"))
            .font(.customFont(.largeTitle, weight: .bold))
    }
}
