import SwiftUI

struct VerticalStepperSection<Content: View>: View {
    var title: String
    var indicatorColor: Color = .gray
    var isFirstSection: Bool = false
    var isLastSection: Bool = false
    var content: [Content]

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.customFont(.body, weight: .bold))
                .foregroundStyle(.textSecondary)
                .padding(.leading, 16)
                .padding(.vertical, 2)
            
                VStack(alignment: .leading) {
                    ForEach(content.indices, id: \.self) { index in
                        VerticalStepperRow(
                            isFirstRow: isFirstSection && index == 0,
                            isLastRow: isLastSection && index == content.count - 1,
                            content: content[index]
                        )
                    }
                }
        }
        .padding(.bottom, 5)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    BackgroundViewWrapper{
        VerticalStepperSection(
            title: "Sample Section",
            isFirstSection: true,
            isLastSection: true,
            content: [
                EmployeeCard(employee: mockEmployee),
            ]
        )
        .background(Color.clear)
        .compositingGroup()
        .padding()
    }
}
