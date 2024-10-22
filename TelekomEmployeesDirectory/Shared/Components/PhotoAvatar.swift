import SDWebImageSwiftUI
import SwiftUI

struct PhotoAvatar: View {
    var imageURL: URL?

    var size: CGFloat = 60

    var body: some View {
        WebImage(url: imageURL) { image in
            image.resizable()
        } placeholder: {
            Image(systemName: "person.circle.fill")
                .resizable()
                .foregroundStyle(.gray)
        }
        .scaledToFill()
        .frame(width: size, height: size, alignment: .center)
        .clipShape(Circle())
    }
}

#Preview {
    VStack {
        PhotoAvatar()
    }
}
