
import Foundation
import SwiftUI
import UIKit

struct BeverageDetailView: View {
    
    let beverage: BeverageDTO
    @State private var image: UIImage?
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    let imageURL =  URL(string: beverage.image)
                    Group {
                        if let image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                        }else {
                            ProgressView()
                        }
                    }.frame(width: geometry.size.width, height: geometry.size.height * 0.40)
                        .clipped()
                        .task(id : imageURL) {
                            if let imgUrl = imageURL {
                                image = await ImageCache.shared.getImageURL(url: imgUrl)
                            }
                        }
                    VStack(alignment: .leading, spacing: 2) {
                        Text(beverage.wine)
                            .font(.title)
                            .fontWeight(.bold)
                        HStack(spacing: 4) {
                            Text(beverage.winery)
                                .font(.title2)
                            Spacer()
                            RatingView(beverage: beverage)
                            Text("(\(beverage.rating.reviews.replacingOccurrences(of: "ratings", with: "reviews")))")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Text(beverage.location.replacingOccurrences(of: "\n·", with: ""))
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }.padding(.horizontal)
                }
            }
            
        }
    }
}
