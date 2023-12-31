import SwiftUI

struct ProfileScreen: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(uiImage: UIImage(named: "Kartika") ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .padding(.bottom, Gap.small)

                Text("Kartika Sari")
                    .font(.title)
                    .lineLimit(1)
                    .padding(.bottom, Gap.tiny)

                Text("Mobile Developer")
                    .font(.title2)
                    .lineLimit(1)
                    .foregroundColor(.secondary)
            }
            .navigationTitle("Profile")
        }
    }
}
