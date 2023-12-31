import SwiftUI

struct GameRateItem<Content: View>: View {
    @State var label: String
    @State var title: String
    @ViewBuilder var text: Content

    var body: some View {
        VStack(
            spacing: Gap.tiny
        ) {
            Text(label)
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
            text
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}
