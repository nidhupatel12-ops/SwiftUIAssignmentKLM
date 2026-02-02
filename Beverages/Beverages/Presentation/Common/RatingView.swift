
import SwiftUI

struct RatingView: View {
    let beverage: BeverageDTO
    var body: some View { HStack(spacing: 4) {
        Image(systemName: "star.fill")
            .foregroundColor(.yellow)
            .font(.caption)
        Text(beverage.rating.average)
            .font(.caption)
            .foregroundColor(.secondary)
    }
    }
}
