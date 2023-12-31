import SwiftUI

struct GameInfoItem: View {
    @State var label: String
    @State var text: String

    var body: some View {
        VStack(
            alignment: .leading
        ) {
            Text(label)
                .foregroundColor(.secondary)
            Text(text)
        }
    }
}
