import SwiftUI

struct RatingView: View {
    @State var rating: Double

    var body: some View {
        let ratingFloor = Int(floor(rating))
        let ratingDecimal = rating.truncatingRemainder(dividingBy: 1)

        HStack(spacing: 0) {
            ForEach(0..<5, id: \.self) { index in
                if index < ratingFloor || ratingDecimal >= 0.75 {
                    Image(systemName: "star.fill")
                } else if index == ratingFloor && ratingDecimal >= 0.25 {
                    Image(systemName: "star.leadinghalf.filled")
                } else {
                    Image(systemName: "star")
                }
            }
        }
        .foregroundColor(.secondary)
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 4.5)
    }
}
